const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const dotenv = require('dotenv');
const morgan = require('morgan');
const { connectDB } = require('./src/config/db');
const errorHandler = require('./middlewares/errorHandler');

// ... otras configuraciones y rutas

app.use(errorHandler);


// Cargar variables de entorno
dotenv.config();

// Inicializar app
const app = express();

// Middleware global
app.use(cors());
app.use(helmet());
app.use(morgan('dev'));
app.use(express.json());

// Conectar a la base de datos
connectDB();

// Rutas protegidas
app.use('/api/auth', require('./src/routes/authRoutes'));
app.use('/api/users', require('./src/routes/usersRoutes'));
app.use('/api/metrics', require('./src/routes/metricsRoutes'));
app.use('/api/moderation', require('./src/routes/moderationRoutes'));
app.use('/api/content', require('./src/routes/contentRoutes'));
app.use('/api/challenges', require('./src/routes/challengesRoutes'));
app.use('/api/reports', require('./src/routes/reportsRoutes'));
app.use('/api/payments', require('./src/routes/payments.routes'));
app.use('/api/settings', require('./src/routes/settings.routes'));

// Ruta raíz
app.get('/', (req, res) => {
  res.send('CrowdKnock API is running 🚀');
});

// Puerto
const PORT = process.env.PORT || 4000;

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`✅ Server running on http://localhost:${PORT}`);
});
