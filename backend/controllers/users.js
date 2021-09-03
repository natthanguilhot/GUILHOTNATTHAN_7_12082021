const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Users } = require("../models");

exports.signup = (req,res,next) => {
    const newUser = Users.findOne({ where: {email: req.body.email}})
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

// s