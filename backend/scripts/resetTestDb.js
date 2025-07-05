const { exec } = require('child_process');
const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../.env.test') });

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
        console.log(`✅ Ejecutado correctamente: ${filePath}`);
        resolve(stdout);
      }
    });
  });
};

(async () => {
  try {
    const initPath = path.resolve(__dirname, 'init.sql');
    const seedPath = path.resolve(__dirname, 'seed.sql');

    console.log('🔄 Reiniciando base de datos de prueba...');
    await runSQLFile(initPath);
    await runSQLFile(seedPath);

    console.log('🎉 Base de datos de prueba reiniciada con éxito.');
  } catch (err) {
    console.error('🚨 Falló la restauración de la base de datos de prueba:', err);
    process.exit(1);
  }
})();
