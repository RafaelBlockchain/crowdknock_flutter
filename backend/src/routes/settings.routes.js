const express = require('express');
const router = express.Router();

const settingsController = require('../controllers/settings.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// 🔐 Proteger todas las rutas con autenticación JWT
router.use(authMiddleware);

// ✅ Obtener todas las configuraciones (usuarios autenticados)
router.get('/', settingsController.getAllSettings);

// ✅ Actualizar una configuración por clave (solo admin)
router.put('/:key', roleMiddleware(['admin']), settingsController.updateSetting);

module.exports = router;
