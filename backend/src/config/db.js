// src/config/db.js

const { Sequelize } = require('sequelize');

// Configuración desde variables de entorno con valores por defecto
const DB_NAME = process.env.DB_NAME || 'crowdknock';
const DB_USER = process.env.DB_USER || 'postgres';
const DB_PASSWORD = process.env.DB_PASSWORD || '';
const DB_HOST = process.env.DB_HOST || 'localhost';
const DB_PORT = process.env.DB_PORT || 5432;

// Instancia de Sequelize
const sequelize = new Sequelize(DB_NAME, DB_USER, DB_PASSWORD, {
  host: DB_HOST,
  port: DB_PORT,
  dialect: 'postgres',
  logging: false, // 🧪 Silenciar logs de SQL en consola
});

// Función para probar la conexión a la base de datos
const connect = async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Conexión exitosa a PostgreSQL con Sequelize');
  } catch (error) {
    console.error('❌ Error al conectar con Sequelize:', error.message);
    throw error;
  }
};

module.exports = {
  connect,
  sequelize,
};
