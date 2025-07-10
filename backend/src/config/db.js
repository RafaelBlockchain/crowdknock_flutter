// src/config/db.js

const { Sequelize } = require('sequelize');

// Cargar configuración desde .env
const sequelize = new Sequelize(
  process.env.DB_NAME || 'crowdknock',
  process.env.DB_USER || 'postgres',
  process.env.DB_PASSWORD || '',
  {
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 5432,
    dialect: 'postgres',
    logging: false, // Desactiva logs en consola
  }
);

// Función para probar la conexión
const connect = async () => {
  try {
    await sequelize.authenticate();
    console.log('📡 Conectado a PostgreSQL con Sequelize');
  } catch (error) {
    console.error('❌ Error al conectar con Sequelize:', error.message);
    throw error;
  }
};

module.exports = {
  connect,
  sequelize,
};
