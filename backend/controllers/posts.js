const { Posts } = require("../models");
const fs = require('fs');

exports.createPost = (req, res, next) => {
    if(req.file){
        Posts.create({
            creator: req.body.userId,
            files: `${req.protocol}://${req.get('host')}/images/posts/${req.file.filename}`,
            content: req.body.content
        })
        .then(() => res.status(201).json({ message : 'Post créé !'}))
        .catch(err => res.status(500).json({ err }))    
    } else {
        Posts.create({
            creator: req.body.userId,
            content: req.body.content
        })
        .then(() => res.status(201).json({ message : 'Post créé !'}))
        .catch(err => res.status(500).json({ err }))    

    }
};

exports.getAllPosts = (req, res, next) => {
    Posts.findAll({ 
        attributes : [['id','postId'],['creator','userId'],'files','content','createdAt','updatedAt'],
    })
    .then(posts => res.status(200).json(posts))
    .catch(err => res.status(500).json({ err }))
};