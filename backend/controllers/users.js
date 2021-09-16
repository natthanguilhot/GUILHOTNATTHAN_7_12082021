const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Users } = require("../models");
const fs = require('fs');

exports.signup = (req,res,next) => {
    console.log(req.body)
    Users.findOne({ where: {email: req.body.email}})
    .then(newUser => {
        if (newUser == null) {
            console.log('Email non trouvé => Création d\' un nouvel utilisateur !')
            bcrypt.genSalt(8, function(err, salt) {
                bcrypt.hash(req.body.password, salt, function(err, hash) {
                    const user = Users.create({
                        email: req.body.email,
                        password: hash,
                        account_type:0,
                        lastname:req.body.lastname, 
                        name:req.body.name,
                        job:req.body.job,
                    });
                    res.status(200).json({message : 'Utilisateur créé !'});
                });
            });    
        } else {
            console.log('Email trouvé => Abandon de création d\'un nouvel utilisateur !')
            res.status(403).json({ message : 'Un compte est déjà associé à cet adresse mail !'})
        }    
    });
};

exports.login = (req,res,next) => {
    Users.findOne({ where : {email: req.body.email}})
    .then(user => {
        if (!user) {
            return res.status(401).json({ error : 'Utilisateur non trouvé !'});
        }
        bcrypt.compare(req.body.password, user.password)
        .then(valid => {
            if(!valid) {
                return res.status(401).json({ error : 'Mot de passe incorrect'});
            }
            res.status(200).json({
                userId: user.id,
                token: jwt.sign(
                    { userId: user.id },
                    `${process.env.TOKEN}`,
                    { expiresIn : '24h'}
                )
            });
        })
        .catch(error => res.status(500).json({ error : 'Bcrypt' }));
    })
    .catch(error => res.status(500).json({ error }));
};

exports.userUpdate = (req,res,next) => {
    Users.findOne({where: {id: req.params.id}})
    .then(user => {
        if(req.file) { // Si un fichier est présent
            if(user.profile_picture != null){ // et si l'utilisateur a déjà une PP alors on remplace l'ancienne par le nouveau fichier
                const filename = user.profile_picture.split('/images/users/')[1];
                fs.unlink(`images/users/${filename}`, () => {
                    Users.update({ 
                        ...req.body, 
                        profile_picture: `${req.protocol}://${req.get('host')}/images/users/${req.file.filename}` },
                        { where : {id: req.params.id}})
                    .then(()=>{
                        res.status(200).json({message : 'PP et/ou données utilisateur modifié !'});
                    })
                    .catch(error => res.status(500).json({ error }));    
                })        
            } else { // Sinon si l'utilisateur n'a pas de PP mais qu'il y a un fichier, on ajoute le fichier en tant que PP
            Users.update({ 
                ...req.body, 
                profile_picture: `${req.protocol}://${req.get('host')}/images/users/${req.file.filename}` },
                { where : {id: req.params.id}})
            .then(()=>{
                res.status(200).json({message : 'Donneés utilisateur modifié et/ou une PP à été ajouté !'});
            })
            .catch(error => res.status(500).json({ error }));   
            }
        } else { // S'il n'y a pas de ficher, on met juste a jour les données
            Users.update({ 
                ...req.body
            },
                { where : {id: req.params.id}})
            .then(()=>{
                res.status(200).json({message : 'Données utilisateur modifié !'});
            })
            .catch(error => res.status(500).json({ error }));  
        }
    });
};

exports.userDelete = (req,res,next) => {
    
    Users.findOne({where: {id: req.params.id}})
    .then(user=>{
        if(user.profile_picture != null) { // Si l'utilisateur a une PP, supprimer d'abord la PP puis supprimer l'utilisateur
            const filename = user.profile_picture.split('/images/users/')[1];
            fs.unlink(`images/users/${filename}`, () => {
                Users.destroy({where: {id: req.params.id}})
                .then(()=> {
                    res.status(200).json({message : 'Utilisateur supprimé !'});
                })
                .catch(error => res.status(500).json({ error }))
            })
        }else { // Sinon supprimer l'utilisateur directement
            Users.destroy({where: {id: req.params.id}})
            .then(()=> {
                res.status(200).json({message : 'Utilisateur supprimé !'});
            })
            .catch(error => res.status(500).json({ error }))
        }
    })
    .catch(error => res.status(500).json({ error }))
};
