const db = require('../config/db');

// ✅ Métricas generales del sistema (usuarios, contenidos, reportes)
const getOverviewMetrics = async (req, res) => {
  try {
    const userCount = await db.one('SELECT COUNT(*) FROM users');
    const contentCount = await db.one('SELECT COUNT(*) FROM contents');
    const reportCount = await db.one('SELECT COUNT(*) FROM reports');

    res.json({
      success: true,
      data: {
        users: parseInt(userCount.count),
        contents: parseInt(contentCount.count),
        reports: parseInt(reportCount.count),
      },
    });
  } catch (error) {
    console.error('Error al obtener métricas generales:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

// ✅ Métricas detalladas por tipo
const getDetailedMetric = async (req, res) => {
  const { type } = req.params;

  try {
    let query;
    switch (type) {
      case 'sessions':
        query = `
          SELECT date_trunc('day', created_at) AS day, COUNT(*) AS count
          FROM user_sessions
          GROUP BY day
          ORDER BY day
        `;
        break;
      case 'reports':
        query = `
          SELECT status, COUNT(*) AS count
          FROM reports
          GROUP BY status
        `;
        break;
      case 'content-type':
        query = `
          SELECT type, COUNT(*) AS count
          FROM contents
          GROUP BY type
        `;
        break;
      default:
        return res.status(400).json({ success: false, error: 'Tipo de métrica no válida' });
    }

    const result = await db.query(query);
    res.json({ success: true, data: result.rows });
  } catch (error) {
    console.error('Error al obtener métricas detalladas:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

module.exports = {
  getOverviewMetrics,
  getDetailedMetric,
};
