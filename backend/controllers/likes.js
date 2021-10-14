const { Likes } = require("../models");

exports.createLike = (req, res, next) => { // 0 dislike || 1 like
    console.log(req.body);
    Likes.create({
        user_id: req.body.userId,
        post_id: req.body.postId,
        comment_id: req.body.commentId,
        is_liked: req.body.isLiked,
    })
    .then(() => res.status(201).json({ message : 'Like ou dislike ajouté !'}))
    .catch(err => res.status(500).json({ err }))
};

exports.getAllLikesFromOnePost = (req, res, next) => {
    Likes.findAll({
        where: {post_id: req.body.postId},
        attributes : [['id','likeId'],'user_id','post_id','comment_id','is_liked','createdAt','updatedAt'],
    })
    .then(likes => res.status(200).json(likes))
    .catch(err => res.status(500).json({ err }))
};

exports.getAllLikesFromOneComment = (req, res, next) => {
    Likes.findAll({
        where: {comment_id: req.body.commentId},
        attributes : [['id','likeId'],'user_id','post_id','comment_id','is_liked','createdAt','updatedAt'],
    })
    .then(likes => res.status(200).json(likes))
    .catch(err => res.status(500).json({ err }))
};