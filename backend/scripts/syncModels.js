// backend/scripts/syncModels.js
const { sequelize } = require('../src/config/db');
const models = require('../src/models');

const syncDatabase = async () => {
  try {
    console.log('🔄 Sincronizando modelos con la base de datos...');
    await sequelize.sync({ alter: true }); // Usa { force: true } si quieres reiniciar las tablas completamente
    console.log('✅ Modelos sincronizados correctamente.');
    process.exit(0);
  } catch (error) {
    console.error('❌ Error al sincronizar modelos:', error);
    process.exit(1);
  }
};

syncDatabase();
