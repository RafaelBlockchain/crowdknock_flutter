require('dotenv').config(); // Cargar variables de entorno

const app = require('./app');
const db = require('./config/db');
const dotenv = require('dotenv');
dotenv.config();

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);

(async () => {
  try {
    await db.connect();
    console.log('✅ Conectado a la base de datos PostgreSQL');

    app.listen(PORT, () => {
      console.log(`🚀 API backend corriendo en http://localhost:${PORT}`);
    });
  } catch (error) {
    console.error('❌ Error al iniciar el servidor:', error.message);
    process.exit(1);
  }
  
})();
