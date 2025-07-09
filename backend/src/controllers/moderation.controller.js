const db = require('../config/db');

// ✅ Obtener todos los reportes pendientes
const getAllReports = async (req, res) => {
  try {
    const result = await db.query(`
      SELECT id, type, content_id, comment_id, reason, status, created_at 
      FROM reports 
      WHERE status = 'pending'
      ORDER BY created_at DESC
    `);
    res.json({ success: true, data: result.rows });
  } catch (error) {
    console.error('Error fetching reports:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

// ✅ Aprobar el reporte (marcar como resuelto)
const approveReport = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await db.query(`UPDATE reports SET status = 'approved' WHERE id = $1 RETURNING id`, [id]);
    if (result.rowCount === 0) {
      return res.status(404).json({ success: false, error: 'Reporte no encontrado' });
    }
    res.json({ success: true, message: 'Reporte aprobado' });
  } catch (error) {
    console.error('Error approving report:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

// ✅ Eliminar contenido o comentario relacionado y actualizar el reporte
const deleteReport = async (req, res) => {
  const { id } = req.params;
  try {
    const report = await db.oneOrNone(`SELECT * FROM reports WHERE id = $1`, [id]);
    if (!report) {
      return res.status(404).json({ success: false, error: 'Reporte no encontrado' });
    }

    const { type, content_id, comment_id } = report;

    if (type === 'content' && content_id) {
      await db.query(`DELETE FROM contents WHERE id = $1`, [content_id]);
    } else if (type === 'comment' && comment_id) {
      await db.query(`DELETE FROM comments WHERE id = $1`, [comment_id]);
    }

    await db.query(`UPDATE reports SET status = 'deleted' WHERE id = $1`, [id]);

    res.json({ success: true, message: 'Contenido eliminado y reporte actualizado' });
  } catch (error) {
    console.error('Error deleting reported content:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

// ✅ Ignorar reporte
const ignoreReport = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await db.query(`UPDATE reports SET status = 'ignored' WHERE id = $1 RETURNING id`, [id]);
    if (result.rowCount === 0) {
      return res.status(404).json({ success: false, error: 'Reporte no encontrado' });
    }
    res.json({ success: true, message: 'Reporte ignorado' });
  } catch (error) {
    console.error('Error ignoring report:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

module.exports = {
  getAllReports,
  approveReport,
  deleteReport,
  ignoreReport,
};
