const express = require('express');
const router = express.Router();

const moderationController = require('../controllers/moderation.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// 🔐 Proteger todas las rutas con autenticación
router.use(authMiddleware);

// ✅ Obtener todos los reportes pendientes
router.get('/reports', moderationController.getAllReports);

// ✅ Aprobar contenido/comentario reportado (solo admin)
router.post(
  '/reports/:id/approve',
  roleMiddleware(['admin']),
  moderationController.approveReport
);

// ✅ Eliminar contenido/comentario reportado (solo admin)
router.post(
  '/reports/:id/delete',
  roleMiddleware(['admin']),
  moderationController.deleteReport
);

// ✅ Ignorar reporte (solo admin)
router.post(
  '/reports/:id/ignore',
  roleMiddleware(['admin']),
  moderationController.ignoreReport
);

module.exports = router;
