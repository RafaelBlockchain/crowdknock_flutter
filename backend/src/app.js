const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./docs/swagger');
const errorHandler = require('./middlewares/errorHandler');

const authRoutes = require('./routes/auth.routes');
const userRoutes = require('./routes/users.routes');
const contentRoutes = require('./routes/content.routes');
const metricsRoutes = require('./routes/metricsRoutes');
const moderationRoutes = require('./routes/moderation.routes');
const paymentsRoutes = require('./routes/payments.routes');
const reportsRoutes = require('./routes/reports.routes');
const settingsRoutes = require('./routes/settings.routes');
const systemRoutes = require('./routes/system.routes');
const systemStatusRoutes = require('./routes/system_status.routes');

const app = express();

// Swagger UI Express
const express = require('express');
const app = express();
const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./swagger.json');

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

// 🌐 Middleware global
app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

// 📄 Documentación Swagger
app.use('/api/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// 📦 Rutas API
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/content', contentRoutes);
app.use('/api/metrics', metricsRoutes);
app.use('/api/moderation', moderationRoutes);
app.use('/api/payments', paymentsRoutes);
app.use('/api/reports', reportsRoutes);
app.use('/api/settings', settingsRoutes);
app.use('/api/system', systemRoutes);
app.use('/api/system-status', systemStatusRoutes);

// 🩹 Middleware de errores (debe ir al final)
app.use(errorHandler);

// 🚀 Endpoint de prueba
app.get('/api/ping', (req, res) => res.json({ message: 'pong 🏓' }));

module.exports = app;

