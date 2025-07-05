const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const User = require('./User');
const Content = require('./Content');

const Report = sequelize.define('Report', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  type: {
    type: DataTypes.ENUM('comment', 'content'),
    allowNull: false,
  },
  reason: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  status: {
    type: DataTypes.ENUM('pending', 'resolved', 'ignored'),
    defaultValue: 'pending',
  }
}, {
  tableName: 'reports',
  timestamps: true,
});

Report.belongsTo(User, { foreignKey: 'reportedById', as: 'reportedBy' });
User.hasMany(Report, { foreignKey: 'reportedById' });

Report.belongsTo(Content, { foreignKey: 'contentId', as: 'content' });
Content.hasMany(Report, { foreignKey: 'contentId' });

module.exports = Report;
