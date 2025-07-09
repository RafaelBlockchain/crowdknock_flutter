const express = require('express');
const router = express.Router();
const metricsController = require('../controllers/metricsController');
const authMiddleware = require('../middlewares/authMiddleware');

// Swagger Docs + Rutas protegidas

/**
 * @swagger
 * /metrics/daily:
 * ...
 */
router.get('/daily', authMiddleware, metricsController.getDailyMetrics);

/**
 * @swagger
 * /metrics/users:
 * ...
 */
router.get('/users', authMiddleware, metricsController.getUserMetrics);

/**
 * @swagger
 * /metrics/content:
 * ...
 */
router.get('/content', authMiddleware, metricsController.getContentMetrics);

/**
 * @swagger
 * /metrics/challenges:
 * ...
 */
router.get('/challenges', authMiddleware, metricsController.getChallengeMetrics);

module.exports = router;
