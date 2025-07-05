const db = require('../config/db');

// Obtener todos los reportes
const getAllReports = async (req, res) => {
  try {
    const result = await db.query(`
      SELECT r.id, r.type, r.reason, r.status, r.created_at,
             r.content_id, r.comment_id,
             c.title AS content_title,
             cm.text AS comment_text
      FROM reports r
      LEFT JOIN content c ON r.content_id = c.id
      LEFT JOIN comments cm ON r.comment_id = cm.id
      ORDER BY r.created_at DESC
    `);
    res.json(result.rows);
  } catch (error) {
    console.error('Error al obtener reportes:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Aprobar reporte
const approveReport = async (req, res) => {
  const { id } = req.params;
  try {
    // Obtener el reporte
    const reportRes = await db.query(`SELECT * FROM reports WHERE id = $1`, [id]);
    const report = reportRes.rows[0];

    if (!report) return res.status(404).json({ message: 'Reporte no encontrado' });

    if (report.content_id) {
      await db.query(`DELETE FROM content WHERE id = $1`, [report.content_id]);
    } else if (report.comment_id) {
      await db.query(`DELETE FROM comments WHERE id = $1`, [report.comment_id]);
    }

    await db.query(`UPDATE reports SET status = 'aprobado' WHERE id = $1`, [id]);

    res.json({ message: 'Reporte aprobado y contenido eliminado' });
  } catch (error) {
    console.error('Error al aprobar reporte:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Ignorar reporte
const ignoreReport = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query(`UPDATE reports SET status = 'ignorado' WHERE id = $1`, [id]);
    res.json({ message: 'Reporte ignorado' });
  } catch (error) {
    console.error('Error al ignorar reporte:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Eliminar reporte
const deleteReport = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query(`DELETE FROM reports WHERE id = $1`, [id]);
    res.json({ message: 'Reporte eliminado' });
  } catch (error) {
    console.error('Error al eliminar reporte:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

module.exports = {
  getAllReports,
  approveReport,
  ignoreReport,
  deleteReport,
};

