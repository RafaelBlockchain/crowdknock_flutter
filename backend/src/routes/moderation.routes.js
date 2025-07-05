const express = require('express');
const router = express.Router();

const moderationController = require('../controllers/moderationController');
const { verifyToken } = require('../middleware/auth');

// Obtener lista de reportes pendientes
router.get('/reports', verifyToken, moderationController.getAllReports);

// Aprobar contenido/comentario reportado
router.post('/reports/:id/approve', verifyToken, moderationController.approveReport);

// Eliminar contenido/comentario reportado
router.post('/reports/:id/delete', verifyToken, moderationController.deleteReport);

// Ignorar un reporte
router.post('/reports/:id/ignore', verifyToken, moderationController.ignoreReport);

module.exports = router;

