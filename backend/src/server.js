require('dotenv').config(); // Carga variables de entorno
const app = require('./src/app');
const db = require('./src/config/db');

const PORT = process.env.PORT || 3000;

(async () => {
  try {
    // 🗄️ Verifica conexión con PostgreSQL
    await db.connect();
    console.log('✅ Conexión exitosa a PostgreSQL');

    // 🚀 Levanta el servidor Express
    app.listen(PORT, () => {
      console.log(`🚀 Servidor backend corriendo en http://localhost:${PORT}`);
    });
  } catch (err) {
    console.error('❌ Error al conectar a la base de datos:', err.message);
    process.exit(1);
  }
})();

