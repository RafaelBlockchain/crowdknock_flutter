const { sequelize } = require('../config/db');

// Importar todos los modelos
const User = require('./User');
const Content = require('./Content');
const Challenge = require('./Challenge');
const Report = require('./Report');
const Payment = require('./Payment');
const Setting = require('./Setting');
const Metric = require('./Metric'); // opcional
const SystemStatus = require('./systemStatus.model')(sequelize, DataTypes);
db.SystemStatus = SystemStatus;

// Las relaciones ya están definidas dentro de cada modelo individualmente.

// Exportar todo junto
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
