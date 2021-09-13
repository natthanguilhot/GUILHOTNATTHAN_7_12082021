const express = require('express');
const router = express.Router();

const postCtrl = require('../controllers/posts');
const multer = require('../middleware/multer-posts-config');
const auth = require('../middleware/auth');


// Create post
router.post('/', auth, multer, postCtrl.createPost);

// Get all posts
router.get('/', postCtrl.getAllPosts);

module.exports = router;

