'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Likes extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  };
  Likes.init({
    id_user: DataTypes.INTEGER,
    id_post: DataTypes.INTEGER,
    id_comment: DataTypes.INTEGER,
    is_liked: DataTypes.BOOLEAN
  }, {
    sequelize,
    modelName: 'Likes',
  });
  return Likes;
};