const express = require('express');
const router = express.Router();

const commentCtrl = require('../controllers/comments');
const auth = require('../middleware/auth');


// Create comment
router.post('/post/:id', auth, commentCtrl.createComment);

// Get all comments from one post
router.get('/post/:id', auth, commentCtrl.getAllCommentsFromOnePost); 

module.exports = router;
