const { User } = require('../models');

/**
 * Obtener todos los usuarios
 */
exports.getAll = async () => {
  try {
    return await User.findAll({
      attributes: ['id', 'name', 'email', 'role', 'createdAt', 'isBanned'],
      order: [['createdAt', 'DESC']],
    });
  } catch (error) {
    console.error('Error al obtener usuarios:', error);
    throw new Error('No se pudieron obtener los usuarios');
  }
};

/**
 * Obtener un usuario por ID
 * @param {string|number} id
 */
exports.getById = async (id) => {
  try {
    const user = await User.findByPk(id);
    if (!user) {
      const err = new Error('Usuario no encontrado');
      err.status = 404;
      throw err;
    }
    return user;
  } catch (error) {
    console.error(`Error al buscar usuario ${id}:`, error);
    throw new Error('No se pudo obtener el usuario');
  }
};

/**
 * Actualizar un usuario
 * @param {string|number} id
 * @param {Object} data
 */
exports.update = async (id, data) => {
  try {
    const user = await User.findByPk(id);
    if (!user) {
      const err = new Error('Usuario no encontrado');
      err.status = 404;
      throw err;
    }
    return await user.update(data);
  } catch (error) {
    console.error(`Error al actualizar usuario ${id}:`, error);
    throw new Error('No se pudo actualizar el usuario');
  }
};

/**
 * Bloquear (banear) un usuario
 * @param {string|number} id
 */
exports.ban = async (id) => {
  try {
    const user = await User.findByPk(id);
    if (!user) {
      const err = new Error('Usuario no encontrado');
      err.status = 404;
      throw err;
    }
    return await user.update({ isBanned: true });
  } catch (error) {
    console.error(`Error al bloquear usuario ${id}:`, error);
    throw new Error('No se pudo bloquear el usuario');
  }
};
