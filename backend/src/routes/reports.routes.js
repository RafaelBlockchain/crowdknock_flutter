const express = require('express');
const router = express.Router();

const reportsController = require('../controllers/reportsController');
const { verifyToken } = require('../middleware/auth');

// Obtener todos los reportes pendientes o procesados
router.get('/', verifyToken, reportsController.getAllReports);

// Aprobar reporte (elimina el contenido/comentario)
router.post('/:id/approve', verifyToken, reportsController.approveReport);

// Ignorar reporte (marcar como resuelto sin eliminar)
router.post('/:id/ignore', verifyToken, reportsController.ignoreReport);

// Eliminar reporte
router.delete('/:id', verifyToken, reportsController.deleteReport);

module.exports = router;

