const express = require('express');
const cors = require('cors');
const morgan = require('morgan');

const config = require('./src/config/env');
const db = require('./src/config/db');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

// Verificar conexión a la base de datos
db.connect()
  .then(() => console.log('✅ Base de datos conectada'))
  .catch((err) => {
    console.error('❌ Error conectando a la base de datos:', err);
    process.exit(1);
  });

// Rutas base (temporalmente vacías)
app.get('/', (req, res) => {
  res.send('CrowdKnock Backend corriendo');
});

// Iniciar servidor
app.listen(config.port, () => {
  console.log(`🚀 Servidor escuchando en http://localhost:${config.port}`);
});
