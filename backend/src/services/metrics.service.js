const { User, Content, Report, Payment } = require('../models');

/**
 * Obtener métricas generales del sistema
 * - Total de usuarios
 * - Total de contenidos
 * - Total de reportes
 * - Total de pagos
 */
async function getMetrics() {
  try {
    const [users, contents, reports, payments] = await Promise.all([
      User.count(),
      Content.count(),
      Report.count(),
      Payment.count(),
    ]);

    return {
      totalUsers: users,
      totalContent: contents,
      totalReports: reports,
      totalPayments: payments,
    };
  } catch (error) {
    console.error('Error al obtener métricas:', error);
    throw new Error('No se pudieron obtener las métricas');
  }
}

module.exports = { getMetrics };
