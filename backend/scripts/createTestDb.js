const { Client } = require('pg');
require('dotenv').config({ path: '.env.test' });

const { DB_USER, DB_PASSWORD, DB_HOST, DB_PORT, DB_NAME } = process.env;

const client = new Client({
  user: DB_USER,
  password: DB_PASSWORD,
  host: DB_HOST,
  port: DB_PORT,
  database: 'postgres',
});

const createTestDb = async () => {
  try {
    await client.connect();
    const check = await client.query(`SELECT 1 FROM pg_database WHERE datname='${DB_NAME}'`);
    if (check.rowCount === 0) {
      await client.query(`CREATE DATABASE "${DB_NAME}"`);
      console.log(`✅ Base de datos "${DB_NAME}" creada correctamente.`);
    } else {
      console.log(`ℹ️  La base de datos "${DB_NAME}" ya existe.`);
    }
  } catch (err) {
    console.error('❌ Error creando base de datos de test:', err);
  } finally {
    await client.end();
  }
};

createTestDb();
