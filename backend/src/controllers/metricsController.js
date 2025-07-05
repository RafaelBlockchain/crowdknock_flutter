const db = require('../config/db');

// Resumen general de métricas
const getOverviewMetrics = async (req, res) => {
  try {
    const [userCount] = await db.query('SELECT COUNT(*) FROM users');
    const [contentCount] = await db.query('SELECT COUNT(*) FROM contents');
    const [reportCount] = await db.query('SELECT COUNT(*) FROM reports');

    res.json({
      users: parseInt(userCount.rows[0].count),
      contents: parseInt(contentCount.rows[0].count),
      reports: parseInt(reportCount.rows[0].count),
    });
  } catch (error) {
    console.error('Error fetching overview metrics:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Métricas detalladas por tipo
const getDetailedMetric = async (req, res) => {
  const { type } = req.params;

  try {
    let query;
    switch (type) {
      case 'sessions':
        query = 'SELECT date_trunc(\'day\', created_at) AS day, COUNT(*) FROM user_sessions GROUP BY day ORDER BY day';
        break;
      case 'reports':
        query = 'SELECT status, COUNT(*) FROM reports GROUP BY status';
        break;
      case 'content-type':
        query = 'SELECT type, COUNT(*) FROM contents GROUP BY type';
        break;
      default:
        return res.status(400).json({ message: 'Tipo de métrica no válida' });
    }

    const result = await db.query(query);
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching detailed metric:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

module.exports = {
  getOverviewMetrics,
  getDetailedMetric,
};
