const express = require('express');
const router = express.Router();

const metricsController = require('../controllers/metricsController');
const { verifyToken } = require('../middleware/auth');

// Ruta para obtener métricas generales del sistema
router.get('/overview', verifyToken, metricsController.getOverviewMetrics);

// Ruta para métricas por tipo (usuarios, contenido, reportes, etc.)
router.get('/details/:type', verifyToken, metricsController.getDetailedMetric);

module.exports = router;
