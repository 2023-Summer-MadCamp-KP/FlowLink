const Sequelize = require('sequelize');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/config')[env];
const db = {};
const sequelize = new Sequelize(config.database, config.username, config.password, config);
db.sequelize = sequelize;

//Add models ------------
const User = require('./user');
const Interest = require('./interest');
const Like = require('./like');
const University = require('./university');

db.User = User;
db.Interest = Interest;
db.Like = Like;
db.University = University;

User.initiate(sequelize);
Interest.initiate(sequelize);
Like.initiate(sequelize);
University.initiate(sequelize);

User.associate(db);
Interest.associate(db);
Like.associate(db);
University.associate(db);
//-----------------------


module.exports = db;