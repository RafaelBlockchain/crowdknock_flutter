// scripts/seed.js
const fs = require('fs');
const path = require('path');
const db = require('../src/config/db');

const seedSql = fs.readFileSync(path.join(__dirname, 'seed.sql'), 'utf-8');

(async () => {
  try {
    await db.query(seedSql);
    console.log('✅ Seeding completado con éxito.');
  } catch (err) {
    console.error('❌ Error ejecutando seed.sql:', err);
  } finally {
    db.end();
  }
})();
