const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const User = require('./User');
const Content = require('./Content');

const Report = sequelize.define(
  'Report',
  {
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
    },
  },
  {
    tableName: 'reports',
    timestamps: true,
    underscored: true,
  }
);

// Relaciones
Report.belongsTo(User, {
  foreignKey: 'reported_by_id',
  as: 'reportedBy',
});
User.hasMany(Report, {
  foreignKey: 'reported_by_id',
  as: 'reports',
});

Report.belongsTo(Content, {
  foreignKey: 'content_id',
  as: 'content',
});
Content.hasMany(Report, {
  foreignKey: 'content_id',
  as: 'reports',
});

module.exports = Report;
