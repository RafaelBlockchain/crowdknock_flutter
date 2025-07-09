const express = require('express');
const router = express.Router();

const systemController = require('../controllers/system.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// ✅ Obtener estado del sistema (solo admin)
router.get('/status', authMiddleware, roleMiddleware(['admin']), systemController.getSystemStatus);

module.exports = router;
