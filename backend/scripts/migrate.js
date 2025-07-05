// scripts/migrate.js
const fs = require('fs');
const path = require('path');
const db = require('../src/config/db');

const initSql = fs.readFileSync(path.join(__dirname, 'init.sql'), 'utf-8');

(async () => {
  try {
    await db.query(initSql);
    console.log('✅ Migración ejecutada con éxito (init.sql)');
  } catch (err) {
    console.error('❌ Error ejecutando migración:', err);
  } finally {
    db.end();
  }
})();
