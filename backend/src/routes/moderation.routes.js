const express = require('express');
const router = express.Router();

const moderationController = require('../controllers/moderation.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// ✅ Obtener lista de reportes pendientes
router.get('/reports', authMiddleware, moderationController.getAllReports);

// ✅ Aprobar contenido/comentario reportado
router.post(
  '/reports/:id/approve',
  authMiddleware,
  roleMiddleware(['admin']),
  moderationController.approveReport
);

// ✅ Eliminar contenido/comentario reportado
router.post(
  '/reports/:id/delete',
  authMiddleware,
  roleMiddleware(['admin']),
  moderationController.deleteReport
);

// ✅ Ignorar un reporte
router.post(
  '/reports/:id/ignore',
  authMiddleware,
  roleMiddleware(['admin']),
  moderationController.ignoreReport
);

module.exports = router;
