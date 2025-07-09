// backend/scripts/seed.js
const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');
const db = require('../src/config/db');
const User = require('../src/models/User');
require('dotenv').config({ path: path.resolve(__dirname, '../.env') });

const seed = async () => {
  try {
    await db.sync({ force: true });

    const admin = await User.create({
      name: 'Admin',
      email: 'admin@example.com',
      password: 'admin123', // Recuerda: usa hash real si necesario
      role: 'admin',
    });

    console.log('✅ Base de datos inicializada con usuario:', admin.email);
    process.exit(0);
  } catch (err) {
    console.error('❌ Error al hacer seed:', err);
    process.exit(1);
  }
};
seed();

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
