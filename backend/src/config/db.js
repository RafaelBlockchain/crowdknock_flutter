const { Sequelize } = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    dialect: 'postgres',
    logging: false, // cambia a true si quieres ver logs SQL
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
