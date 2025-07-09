const express = require('express');
const router = express.Router();

const reportsController = require('../controllers/reports.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// ✅ Obtener todos los reportes (autenticado)
router.get('/', authMiddleware, reportsController.getAllReports);

// ✅ Aprobar reporte (requiere admin)
router.post('/:id/approve', authMiddleware, roleMiddleware(['admin']), reportsController.approveReport);

// ✅ Ignorar reporte (requiere admin)
router.post('/:id/ignore', authMiddleware, roleMiddleware(['admin']), reportsController.ignoreReport);

// ✅ Eliminar reporte (requiere admin)
router.delete('/:id', authMiddleware, roleMiddleware(['admin']), reportsController.deleteReport);

module.exports = router;

