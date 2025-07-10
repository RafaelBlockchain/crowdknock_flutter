// src/main.js

require('dotenv').config(); // Cargar variables de entorno

const app = require('./app');
const db = require('./config/db');

const PORT = process.env.PORT || 3000;

// Función para iniciar la app
(async () => {
  try {
    await db.connect(); // Conexión a la base de datos
    console.log('✅ Conectado a la base de datos PostgreSQL');

    app.listen(PORT, () => {
      console.log(`🚀 API backend corriendo en http://localhost:${PORT}`);
    });
  } catch (error) {
    console.error('❌ Error al iniciar el servidor:', error.message);
    process.exit(1); // Salir con código de error
  }
})();
