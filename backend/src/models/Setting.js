const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Setting = sequelize.define(
  'Setting',
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    key: {
      type: DataTypes.STRING,
      unique: true,
      allowNull: false,
      validate: {
        notEmpty: true,
      },
    },
    value: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
  },
  {
    tableName: 'settings',
    timestamps: true,
    underscored: true,
  }
);

module.exports = Setting;
