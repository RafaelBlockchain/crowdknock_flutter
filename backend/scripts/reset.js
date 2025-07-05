// backend/scripts/reset.js
const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');
require('dotenv').config({ path: path.resolve(__dirname, '../.env') });

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false,
});

const initSqlPath = path.join(__dirname, '../db/init.sql');
const seedSqlPath = path.join(__dirname, '../db/seed.sql');

const initSql = fs.readFileSync(initSqlPath, 'utf8');
const seedSql = fs.readFileSync(seedSqlPath, 'utf8');

(async () => {
  try {
    console.log('🧨 Reiniciando base de datos con init.sql...');
    await pool.query(initSql);
    console.log('✅ Estructura creada correctamente.');

    console.log('🌱 Insertando datos de ejemplo con seed.sql...');
    await pool.query(seedSql);
    console.log('✅ Datos insertados correctamente.');
  } catch (error) {
    console.error('❌ Error durante el reseteo:', error);
  } finally {
    await pool.end();
  }
})();
