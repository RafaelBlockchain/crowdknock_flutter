const reportsService = require('../services/reports.service');

exports.getAllReports = async (req, res) => {
  try {
    const reports = await reportsService.getPendingReports();
    res.json({ success: true, data: reports });
  } catch (error) {
    console.error('Error fetching reports:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

exports.approveReport = async (req, res) => {
  try {
    const updated = await reportsService.approve(req.params.id);
    if (!updated) {
      return res.status(404).json({ success: false, error: 'Reporte no encontrado' });
    }
    res.json({ success: true, message: 'Reporte aprobado' });
  } catch (error) {
    console.error('Error approving report:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

exports.deleteReportedItem = async (req, res) => {
  try {
    const updated = await reportsService.deleteReportedContent(req.params.id);
    if (!updated) {
      return res.status(404).json({ success: false, error: 'Reporte no encontrado' });
    }
    res.json({ success: true, message: 'Contenido eliminado y reporte actualizado' });
  } catch (error) {
    console.error('Error deleting reported content:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

exports.ignoreReport = async (req, res) => {
  try {
    const ignored = await reportsService.ignore(req.params.id);
    if (!ignored) {
      return res.status(404).json({ success: false, error: 'Reporte no encontrado' });
    }
    res.json({ success: true, message: 'Reporte ignorado' });
  } catch (error) {
    console.error('Error ignoring report:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};
