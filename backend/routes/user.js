const express = require('express');
const router = express.Router();
const userCtrl = require('../controllers/users');
const multer = require('../middleware/multer-users-config');
const auth = require('../middleware/auth');

// CREATE USER
router.post('/signup', userCtrl.signup);

// LOGIN USER
router.post('/login', userCtrl.login);

//MODIFY USER
router.put('/user/:id', multer, userCtrl.userUpdate);

// DELETE USER
router.delete('/user/:id', userCtrl.userDelete);


module.exports = router;