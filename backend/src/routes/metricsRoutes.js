const express = require('express');
const router = express.Router();
const metricsController = require('../controllers/metricsController');
const authMiddleware = require('../middlewares/authMiddleware');

// ✅ protección con middleware
router.get('/', authMiddleware, controller.handler);
router.post('/', authMiddleware, roleMiddleware(['admin']), controller.handler);

// Swagger Docs + Rutas protegidas
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

/**
 * @swagger
 * /metrics/users:
 *   get:
 *     summary: Obtener estadísticas generales de usuarios
 *     tags: [Metrics]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Estadísticas de usuarios
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 totalUsers:
 *                   type: integer
 *                 activeUsers:
 *                   type: integer
 *                 newUsersToday:
 *                   type: integer
 */
router.get('/users', authMiddleware, metricsController.getUserMetrics);

/**
 * @swagger
 * /metrics/content:
 *   get:
 *     summary: Obtener estadísticas del contenido subido
 *     tags: [Metrics]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Estadísticas de contenido
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 totalContent:
 *                   type: integer
 *                 approved:
 *                   type: integer
 *                 rejected:
 *                   type: integer
 */
router.get('/content', authMiddleware, metricsController.getContentMetrics);

/**
 * @swagger
 * /metrics/challenges:
 *   get:
 *     summary: Obtener estadísticas de desafíos ciudadanos
 *     tags: [Metrics]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Estadísticas de desafíos
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 totalChallenges:
 *                   type: integer
 *                 activeChallenges:
 *                   type: integer
 *                 closedChallenges:
 *                   type: integer
 */
router.get('/challenges', authMiddleware, metricsController.getChallengeMetrics);
module.exports = router;
