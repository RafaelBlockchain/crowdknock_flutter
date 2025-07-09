const { sequelize } = require('../config/db');
const { DataTypes } = require('sequelize');

// Importar todos los modelos
const User = require('./User');
const Content = require('./Content');
const Challenge = require('./Challenge');
const Report = require('./Report');
const Payment = require('./Payment');
const Setting = require('./Setting');
const Metric = require('./Metric');
const SystemStatus = require('./systemStatus.model')(sequelize, DataTypes);

// ⚠️ Relaciones ya definidas dentro de cada modelo individual

// Exportar todo
module.exports = {
  sequelize,
  User,
  Content,
  Challenge,
  Report,
  Payment,
  Setting,
  Metric,
  SystemStatus,
};
