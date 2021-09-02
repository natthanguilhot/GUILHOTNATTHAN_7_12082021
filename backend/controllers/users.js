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
                        profile_picture:req.body.profile_picture,
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