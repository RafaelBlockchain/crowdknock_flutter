const express = require('express');
const router = express.Router();
const settingsController = require('../controllers/settings.controller');
const authMiddleware = require('../middleware/auth');

// ✅ protección con middleware
router.get('/', authMiddleware, controller.handler);
router.post('/', authMiddleware, roleMiddleware(['admin']), controller.handler);

// Proteger todas las rutas con JWT
router.use(authMiddleware.verifyToken);

// GET /settings → Obtener todas las configuraciones
router.get('/', settingsController.getAllSettings);

// PUT /settings/:key → Actualizar configuración por clave
router.put('/:key', settingsController.updateSetting);


// Controlador simulado de configuración
const settingsController = {
  getSettings: async (req, res) => {
    try {
      // Esto puede venir de la base de datos
      const settings = {
        maintenanceMode: false,
        maxUploadSizeMB: 50,
        supportEmail: 'soporte@crowdknock.com',
        version: '1.0.0'
      };
      res.json(settings);
    } catch (error) {
      console.error('Error al obtener configuración:', error);
      res.status(500).json({ error: 'Error al obtener configuración' });
    }
  },

  updateSettings: async (req, res) => {
    try {
      const updates = req.body;
      // Aquí aplicarías los cambios en la base de datos
      res.json({
        message: 'Configuración actualizada correctamente',
        updated: updates
      });
    } catch (error) {
      console.error('Error al actualizar configuración:', error);
      res.status(500).json({ error: 'Error al actualizar configuración' });
    }
  }
};

// Rutas protegidas
router.get('/', authMiddleware, settingsController.getSettings);
router.put('/', authMiddleware, settingsController.updateSettings);

module.exports = router;

