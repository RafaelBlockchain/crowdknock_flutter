const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Metric = sequelize.define(
  'Metric',
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
    value: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    recordedAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
      field: 'recorded_at',
    },
  },
  {
    tableName: 'metrics',
    timestamps: false,
    underscored: true,
  }
);

module.exports = Metric;
