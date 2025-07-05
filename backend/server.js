const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const morgan = require('morgan');
const helmet = require('helmet');

const app = express();

// Cargar variables de entorno
dotenv.config();

// Middlewares globales
app.use(cors());
app.use(helmet());
app.use(morgan('dev'));
app.use(express.json());

// Conexión a la base de datos
const db = require('./src/config/db');

// Probar conexión
db.connect()
  .then(() => console.log('✅ Conexión a PostgreSQL establecida.'))
  .catch((err) => console.error('❌ Error de conexión a PostgreSQL:', err));

// Importar rutas
const authRoutes = require('./src/routes/authRoutes');
const usersRoutes = require('./src/routes/usersRoutes');
const metricsRoutes = require('./src/routes/metricsRoutes');
const moderationRoutes = require('./src/routes/moderationRoutes');
const contentRoutes = require('./src/routes/contentRoutes');
const challengesRoutes = require('./src/routes/challengesRoutes');
const reportsRoutes = require('./src/routes/reportsRoutes');

// Prefijo común para API
app.use('/api/auth', authRoutes);
app.use('/api/users', usersRoutes);
app.use('/api/metrics', metricsRoutes);
app.use('/api/moderation', moderationRoutes);
app.use('/api/content', contentRoutes);
app.use('/api/challenges', challengesRoutes);
app.use('/api/reports', reportsRoutes);

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('🚀 API de CrowdKnock Admin funcionando.');
});

// Puerto del servidor
const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`🚀 Servidor backend escuchando en http://localhost:${PORT}`);
});
