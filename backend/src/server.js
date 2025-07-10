// main.js

require('dotenv').config(); // 🌱 Carga variables de entorno

const app = require('./src/app');
const db = require('./src/config/db');
const fs = require('fs');

const PORT = process.env.PORT || 3000;

// Crear carpeta uploads si no existe
if (!fs.existsSync('uploads')) {
  fs.mkdirSync('uploads');
}

const PORT = process.env.PORT || 4000;

app.listen(PORT, () => {
  console.log(`Servidor escuchando en puerto ${PORT}`);
});

(async () => {
  try {
    // 🗄️ Conexión con PostgreSQL
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

