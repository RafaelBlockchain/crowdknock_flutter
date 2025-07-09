const { Content } = require('../models');

/**
 * Obtener todos los contenidos
 */
async function getAllContent() {
  return await Content.findAll();
}

/**
 * Crear nuevo contenido
 * @param {Object} data
 */
async function createContent(data) {
  return await Content.create(data);
}

/**
 * Actualizar contenido existente
 * @param {String} id
 * @param {Object} updates
 */
async function updateContent(id, updates) {
  const content = await Content.findByPk(id);
  if (!content) {
    const error = new Error('Contenido no encontrado');
    error.status = 404;
    throw error;
  }
  return await content.update(updates);
}

/**
 * Eliminar contenido
 * @param {String} id
 */
async function deleteContent(id) {
  const content = await Content.findByPk(id);
  if (!content) {
    const error = new Error('Contenido no encontrado');
    error.status = 404;
    throw error;
  }
  await content.destroy();
  return { message: 'Contenido eliminado correctamente' };
}

module.exports = {
  getAllContent,
  createContent,
  updateContent,
  deleteContent,
};
