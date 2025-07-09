const { Sequelize } = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST || 'localhost',
    dialect: 'postgres',
    port: process.env.DB_PORT || 5432,
    logging: false,
  }
);

const connectToDB = async () => {
  try {
    await sequelize.authenticate();
    console.log('🟢 Conexión con PostgreSQL establecida correctamente.');
  } catch (error) {
    console.error('🔴 Error al conectar con PostgreSQL:', error.message);
  }
};

module.exports = { sequelize, connectToDB };
