const settingsService = require('../services/settings.service');

exports.getAllSettings = async (req, res) => {
  try {
    const settings = await settingsService.getAll();
    res.json({ success: true, data: settings });
  } catch (error) {
    console.error('Error al obtener configuraciones:', error);
    res.status(500).json({ success: false, error: 'Error al obtener configuraciones' });
  }
};

exports.updateSetting = async (req, res) => {
  try {
    const { key } = req.params;
    const { value } = req.body;

    if (!key || typeof value === 'undefined') {
      return res.status(400).json({
        success: false,
        error: 'La clave y el valor son requeridos',
      });
    }

    await settingsService.upsert(key, value);

    res.json({
      success: true,
      message: 'Configuración actualizada correctamente',
      data: { key, value },
    });
  } catch (error) {
    console.error('Error al actualizar configuración:', error);
    res.status(500).json({ success: false, error: 'Error al actualizar configuración' });
  }
};

