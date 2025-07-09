const express = require('express');
const router = express.Router();

const reportsController = require('../controllers/reports.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// 🔐 Todas las rutas requieren autenticación
router.use(authMiddleware);

// ✅ Obtener todos los reportes (cualquier usuario autenticado)
router.get('/', reportsController.getAllReports);

// ✅ Aprobar reporte (solo admin)
router.post('/:id/approve', roleMiddleware(['admin']), reportsController.approveReport);

// ✅ Ignorar reporte (solo admin)
router.post('/:id/ignore', roleMiddleware(['admin']), reportsController.ignoreReport);

// ✅ Eliminar reporte (solo admin)
router.delete('/:id', roleMiddleware(['admin']), reportsController.deleteReport);

module.exports = router;
