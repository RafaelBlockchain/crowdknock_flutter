const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const User = require('./User');

const Content = sequelize.define(
  'Content',
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    type: {
      type: DataTypes.ENUM('video', 'audio', 'story'),
      allowNull: false,
    },
    title: {
      type: DataTypes.STRING,
      allowNull: false,
      validate: {
        notEmpty: true,
      },
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    url: {
      type: DataTypes.STRING,
      allowNull: false,
      validate: {
        isUrl: true,
      },
    },
    status: {
      type: DataTypes.ENUM('published', 'pending', 'deleted'),
      defaultValue: 'pending',
    },
  },
  {
    tableName: 'contents',
    timestamps: true,
    underscored: true,
  }
);

// Relaciones
Content.belongsTo(User, { foreignKey: 'user_id', as: 'owner' });
User.hasMany(Content, { foreignKey: 'user_id' });

module.exports = Content;
