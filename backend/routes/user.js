const express = require('express');
const router = express.Router();
const userCtrl = require('../controllers/users');
// const multer = require('../middleware/multer-config');
const auth = require('../middleware/auth');

router.post('/signup', userCtrl.signup);
router.post('/login', userCtrl.login);
router.put('/user/:id', auth, userCtrl.user);

module.exports = router;