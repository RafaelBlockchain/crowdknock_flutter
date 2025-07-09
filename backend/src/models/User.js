const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const User = sequelize.define(
  'User',
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      validate: {
        notEmpty: true,
      },
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
      validate: {
        isEmail: true,
      },
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    role: {
      type: DataTypes.ENUM('user', 'moderator', 'admin'),
      defaultValue: 'user',
    },
    status: {
      type: DataTypes.ENUM('active', 'banned'),
      defaultValue: 'active',
    },
  },
  {
    tableName: 'users',
    timestamps: true,
    underscored: true,
  }
);

module.exports = User;
