const multer = require('multer');
// const { DATE } = require('sequelize');

const MIME_TYPES = {
    'image/jpg': 'jpg',
    'image/jpeg': 'jpeg',
    'image/png': 'png',
    'image/gif': 'gif',
}

const storage = multer.diskStorage({
    destination: (req,file,callback) => {
        if(req.body.creator) {
            callback(null, 'images/users')
        } else {
            callback(null, 'images/posts')
        }
    },
    filename: (req,file,callback) => {
        const name = file.originalname.split(' ').join('_');
        const extension = MIME_TYPES[file.mimetype];
        callback(null, name + Date.now() + '.' + extension);
    }
});

module.exports = multer({ storage }).single('files');