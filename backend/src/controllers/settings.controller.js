const db = require('../config/db');

const settingsController = {
  // ✅ Obtener todas las configuraciones
  getAllSettings: async (req, res) => {
    try {
      const settings = await db.any('SELECT key, value FROM settings');
      const formatted = {};
      settings.forEach((s) => {
        formatted[s.key] = s.value;
      });
      res.json({ success: true, data: formatted });
    } catch (error) {
      console.error('Error al obtener configuraciones:', error);
      res.status(500).json({ success: false, error: 'Error al obtener configuraciones' });
    }
  },

  // ✅ Actualizar una configuración por clave
  updateSetting: async (req, res) => {
    try {
      const { key } = req.params;
      const { value } = req.body;

      if (!key || typeof value === 'undefined') {
        return res.status(400).json({
          success: false,
          error: 'La clave y el valor son requeridos',
        });
      }

      await db.none(
        `INSERT INTO settings (key, value)
         VALUES ($1, $2)
         ON CONFLICT (key)
         DO UPDATE SET value = EXCLUDED.value`,
        [key, value]
      );

      res.json({
        success: true,
        message: 'Configuración actualizada correctamente',
        data: { key, value },
      });
    } catch (error) {
      console.error('Error al actualizar configuración:', error);
      res.status(500).json({ success: false, error: 'Error al actualizar configuración' });
    }
  },
};

module.exports = settingsController;
