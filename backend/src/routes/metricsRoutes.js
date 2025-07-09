const express = require('express');
const router = express.Router();

const metricsController = require('../controllers/metricsController');
const { verifyToken } = require('../middleware/auth');

// Ruta para obtener métricas generales del sistema
router.get('/overview', verifyToken, metricsController.getOverviewMetrics);

// Ruta para métricas por tipo (usuarios, contenido, reportes, etc.)
router.get('/details/:type', verifyToken, metricsController.getDetailedMetric);

/**
 * @swagger
 * /metrics/daily:
 *   get:
 *     summary: Obtener métricas diarias de usuarios y uso de la app
 *     tags: [Metrics]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de métricas por día
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   date:
 *                     type: string
 *                     format: date
 *                   active_users:
 *                     type: number
 *                   session_duration_avg:
 *                     type: number
 *                   crash_count:
 *                     type: number
 *       401:
 *         description: No autorizado
 */
router.get('/daily', authMiddleware, metricsController.getDailyMetrics);
module.exports = router;
