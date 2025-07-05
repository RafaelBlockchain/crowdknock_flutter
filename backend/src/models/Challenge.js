const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Challenge = sequelize.define('Challenge', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  description: DataTypes.TEXT,
  startDate: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  endDate: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  status: {
    type: DataTypes.ENUM('active', 'inactive', 'completed'),
    defaultValue: 'active',
  }
}, {
  tableName: 'challenges',
  timestamps: true,
});

module.exports = Challenge;
