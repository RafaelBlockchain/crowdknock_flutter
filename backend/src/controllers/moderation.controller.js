const db = require('../config/db');

// Obtener todos los reportes pendientes
const getAllReports = async (req, res) => {
  try {
    const result = await db.query(`
      SELECT id, type, content_id, comment_id, reason, status, created_at 
      FROM reports 
      WHERE status = 'pending'
      ORDER BY created_at DESC
    `);
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching reports:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Aprobar el reporte (marcar como resuelto)
const approveReport = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query(`UPDATE reports SET status = 'approved' WHERE id = $1`, [id]);
    res.json({ message: 'Reporte aprobado' });
  } catch (error) {
    console.error('Error approving report:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Eliminar contenido o comentario relacionado
const deleteReport = async (req, res) => {
  const { id } = req.params;
  try {
    const report = await db.query(`SELECT * FROM reports WHERE id = $1`, [id]);
    if (report.rows.length === 0) return res.status(404).json({ message: 'Reporte no encontrado' });

    const { type, content_id, comment_id } = report.rows[0];

    if (type === 'content' && content_id) {
      await db.query(`DELETE FROM contents WHERE id = $1`, [content_id]);
    } else if (type === 'comment' && comment_id) {
      await db.query(`DELETE FROM comments WHERE id = $1`, [comment_id]);
    }

    await db.query(`UPDATE reports SET status = 'deleted' WHERE id = $1`, [id]);

    res.json({ message: 'Contenido eliminado y reporte actualizado' });
  } catch (error) {
    console.error('Error deleting reported content:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Ignorar reporte
const ignoreReport = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query(`UPDATE reports SET status = 'ignored' WHERE id = $1`, [id]);
    res.json({ message: 'Reporte ignorado' });
  } catch (error) {
    console.error('Error ignoring report:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

module.exports = {
  getAllReports,
  approveReport,
  deleteReport,
  ignoreReport,
};

