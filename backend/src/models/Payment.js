const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const User = require('./User');

const Payment = sequelize.define('Payment', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  amount: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  status: {
    type: DataTypes.ENUM('pending', 'approved', 'rejected'),
    defaultValue: 'pending',
  },
  method: {
    type: DataTypes.STRING,
    allowNull: false,
  }
}, {
  tableName: 'payments',
  timestamps: true,
});

Payment.belongsTo(User, { foreignKey: 'userId' });
User.hasMany(Payment, { foreignKey: 'userId' });

module.exports = Payment;
