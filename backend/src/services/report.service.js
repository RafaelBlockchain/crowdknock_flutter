const { Report, Content, User } = require('../models');

/**
 * Obtener todos los reportes con su contenido y usuario asociados
 */
exports.getAll = async () => {
  try {
    return await Report.findAll({
      include: [
        {
          model: Content,
          attributes: ['id', 'title', 'type'],
        },
        {
          model: User,
          attributes: ['id', 'name', 'email'],
        },
      ],
      order: [['createdAt', 'DESC']],
    });
  } catch (error) {
    console.error('Error al obtener reportes:', error);
    throw new Error('No se pudieron obtener los reportes');
  }
};

/**
 * Resolver un reporte con una descripción o estado
 * @param {string} id - ID del reporte
 * @param {string} resolution - Texto de resolución
 */
exports.resolve = async (id, resolution) => {
  try {
    const report = await Report.findByPk(id);
    if (!report) {
      const error = new Error('Reporte no encontrado');
      error.status = 404;
      throw error;
    }

    return await report.update({
      resolved: true,
      resolution: resolution || 'Resuelto',
      resolvedAt: new Date(),
    });
  } catch (error) {
    console.error(`Error al resolver reporte ${id}:`, error);
    throw new Error('No se pudo resolver el reporte');
  }
};
