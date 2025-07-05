const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const User = require('./User');

const Content = sequelize.define('Content', {
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
  },
  description: DataTypes.TEXT,
  url: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  status: {
    type: DataTypes.ENUM('published', 'pending', 'deleted'),
    defaultValue: 'pending',
  }
}, {
  tableName: 'contents',
  timestamps: true,
});

Content.belongsTo(User, { foreignKey: 'userId', as: 'owner' });
User.hasMany(Content, { foreignKey: 'userId' });

module.exports = Content;
