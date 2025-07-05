// backend/scripts/seed.js
const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');
require('dotenv').config({ path: path.resolve(__dirname, '../.env') });

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false,
});

const seedSqlPath = path.join(__dirname, '../db/seed.sql');
const seedSql = fs.readFileSync(seedSqlPath, 'utf8');

(async () => {
  try {
    console.log('⏳ Ejecutando seed.sql...');
    await pool.query(seedSql);
    console.log('✅ Datos de ejemplo insertados con éxito.');
  } catch (error) {
    console.error('❌ Error al ejecutar seed.sql:', error);
  } finally {
    await pool.end();
  }
})();
