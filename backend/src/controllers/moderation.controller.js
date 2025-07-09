const moderationService = require('../services/moderation.service');

exports.getReportedVideos = async (req, res) => {
  try {
    const reports = await moderationService.getReportedVideos();
    res.json({ success: true, data: reports });
  } catch (error) {
    console.error('Error al obtener videos reportados:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

exports.getReportedComments = async (req, res) => {
  try {
    const reports = await moderationService.getReportedComments();
    res.json({ success: true, data: reports });
  } catch (error) {
    console.error('Error al obtener comentarios reportados:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

exports.markAsReviewed = async (req, res) => {
  try {
    const updated = await moderationService.markAsReviewed(req.params.id);
    if (!updated) {
      return res.status(404).json({ success: false, error: 'Reporte no encontrado' });
    }

    res.json({ success: true, message: 'Reporte marcado como revisado' });
  } catch (error) {
    console.error('Error al marcar como revisado:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};
