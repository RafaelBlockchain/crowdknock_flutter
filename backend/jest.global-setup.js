const path = require('path');
const { exec } = require('child_process');
require('dotenv').config({ path: path.resolve(__dirname, '.env.test') });

const {
  DB_USER,
  DB_PASSWORD,
  DB_HOST,
  DB_PORT,
  DB_NAME,
} = process.env;

const runSQLFile = (filePath) => {
  return new Promise((resolve, reject) => {
    const command = `psql -U ${DB_USER} -h ${DB_HOST} -p ${DB_PORT} -d ${DB_NAME} -f "${filePath}"`;
    const env = { ...process.env, PGPASSWORD: DB_PASSWORD };

    exec(command, { env }, (error, stdout, stderr) => {
      if (error) {
        console.error(`❌ Error ejecutando ${filePath}:\n${stderr}`);
        reject(error);
      } else {
        console.log(`✅ Ejecutado: ${filePath}`);
        resolve(stdout);
      }
    });
  });
};

module.exports = async () => {
  const initPath = path.resolve(__dirname, 'scripts/init.sql');
  const seedPath = path.resolve(__dirname, 'scripts/seed.sql');

  console.log('🔁 Restaurando base de datos de prueba antes de correr tests...');

  try {
    await runSQLFile(initPath);
    await runSQLFile(seedPath);
    console.log('✅ Base de datos de pruebas restaurada.');
  } catch (error) {
    console.error('🚨 Error al restaurar la base de datos de pruebas:', error);
    process.exit(1);
  }
};
