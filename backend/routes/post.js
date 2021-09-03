const express = require('express');
const router = express.Router();
const postCtrl = require('../controllers/posts');
const multer = require('../middleware/multer-config');
const auth = require('../middleware/auth');


// Create post
router.post('/',auth, postCtrl.createPost);

// Get all posts
router.get('/', auth, postCtrl.getAllPosts);

module.exports = router;