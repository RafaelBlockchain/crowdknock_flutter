const express = require('express');
const router = express.Router();

const metricsController = require('../controllers/metrics.controller');
const authMiddleware = require('../middlewares/authMiddleware');

// 🔐 Proteger todas las rutas con JWT
router.use(authMiddleware);

// ✅ Métricas diarias de uso
router.get('/daily', metricsController.getDailyMetrics);

// ✅ Estadísticas de usuarios
router.get('/users', metricsController.getUserMetrics);

// ✅ Estadísticas de contenido
router.get('/content', metricsController.getContentMetrics);

// ✅ Estadísticas de desafíos
router.get('/challenges', metricsController.getChallengeMetrics);

module.exports = router;

