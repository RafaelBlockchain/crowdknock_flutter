const { exec } = require('child_process');
require('dotenv').config({ path: '.env.test' });

const { DB_HOST, DB_PORT, DB_USER, DB_NAME } = process.env;

const psqlCmd = (script) =>
  `psql -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USER} -d ${DB_NAME} -f scripts/${script}`;

const reset = async () => {
  console.log('🔄 Reiniciando base de datos de pruebas...');

  const init = exec(psqlCmd('init.sql'), { env: process.env });
  init.stdout.pipe(process.stdout);
  init.stderr.pipe(process.stderr);

  init.on('exit', (code) => {
    if (code === 0) {
      const seed = exec(psqlCmd('seed.sql'), { env: process.env });
      seed.stdout.pipe(process.stdout);
      seed.stderr.pipe(process.stderr);

      seed.on('exit', (code2) => {
        if (code2 === 0) {
          console.log('✅ Base de datos de pruebas reiniciada.');
        } else {
          console.error('❌ Error al ejecutar seed.sql');
        }
      });
    } else {
      console.error('❌ Error al ejecutar init.sql');
    }
  });
};

reset();
