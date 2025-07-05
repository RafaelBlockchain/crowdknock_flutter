// backend/server.js
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');

const authRoutes = require('./src/routes/auth.routes');
const usersRoutes = require('./src/routes/users.routes');
const metricsRoutes = require('./src/routes/metrics.routes');
const moderationRoutes = require('./src/routes/moderation.routes');
const contentRoutes = require('./src/routes/content.routes');
const challengesRoutes = require('./src/routes/challenges.routes');
const reportsRoutes = require('./src/routes/reports.routes');
const paymentsRoutes = require('./src/routes/payments.routes');
const settingsRoutes = require('./src/routes/settings.routes');

const authMiddleware = require('./src/middlewares/authMiddleware');
const roleMiddleware = require('./src/middlewares/roleMiddleware');
const errorHandler = require('./src/middlewares/errorHandler');

const app = express();

app.use(cors());
app.use(helmet());
app.use(express.json());

// Rutas públicas
app.use('/api/auth', authRoutes);

// Rutas protegidas (requieren autenticación)
app.use('/api/users', authMiddleware, usersRoutes);
app.use('/api/metrics', authMiddleware, metricsRoutes);
app.use('/api/moderation', authMiddleware, moderationRoutes);
app.use('/api/content', authMiddleware, contentRoutes);
app.use('/api/challenges', authMiddleware, challengesRoutes);
app.use('/api/reports', authMiddleware, reportsRoutes);
app.use('/api/payments', authMiddleware, paymentsRoutes);
app.use('/api/settings', authMiddleware, settingsRoutes);

// Ejemplo de ruta protegida solo para admins
// app.use('/api/admin', authMiddleware, roleMiddleware('admin'), adminRoutes);

app.use(errorHandler);

const PORT = process.env.PORT || 4000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
