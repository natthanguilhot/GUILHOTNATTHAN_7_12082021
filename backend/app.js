const express = require('express');
const app = express();
const { Sequelize } = require('sequelize');
const userRoutes = require('./routes/user');
const postsRoutes = require('./routes/post');
const path = require('path');
const dotenv = require('dotenv');
dotenv.config();

const sequelize = new Sequelize(process.env.NAME_DATABSE, process.env.USER_DATABSE, null, {
    host: process.env.HOST,
    dialect: 'mysql'
});


sequelize.authenticate()
.then(() => console.log('Connexion à MySQL réussie !'))
.catch(() => console.log('Connexion à MySQL échouée !'));

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
    next();
});

app.use(express.json());

app.use('/images/posts', express.static(path.join(__dirname, 'images/posts')));
app.use('/images/users', express.static(path.join(__dirname, 'images/users')))


app.use('/api/auth', userRoutes);
app.use('/api/posts', postsRoutes);

module.exports = app;