const { Report, Content, User } = require('../models');

/**
 * Obtener todos los reportes, ordenados por fecha descendente
 */
async function getAllReports() {
  try {
    return await Report.findAll({
      include: [Content, User],
      order: [['createdAt', 'DESC']],
    });
  } catch (error) {
    console.error('Error al obtener reportes:', error);
    throw new Error('No se pudieron obtener los reportes');
  }
}

/**
 * Resolver un reporte
 * @param {string} id - ID del reporte
 * @param {string} resolution - Descripción o estado de resolución
 */
async function resolveReport(id, resolution) {
  try {
    const report = await Report.findByPk(id);
    if (!report) {
      const error = new Error('Reporte no encontrado');
      error.status = 404;
      throw error;
    }

    return await report.update({ resolved: true, resolution });
  } catch (error) {
    console.error(`Error al resolver reporte ${id}:`, error);
    throw new Error('No se pudo resolver el reporte');
  }
}

module.exports = {
  getAllReports,
  resolveReport,
};
