const { json } = require('express');
const express = require('express');
const app = express();
const { Sequelize } = require('sequelize');
const userRoutes = require('./routes/user');

const sequelize = new Sequelize(process.env.NAME_DATABSE, 'root', process.env.PASSWORD_DATABSE, {
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

app.use(json());

app.use('/api/auth', userRoutes);

module.exports = app;