const { User } = require('../models');

/**
 * Obtener todos los usuarios
 */
async function getAllUsers() {
  try {
    return await User.findAll();
  } catch (error) {
    console.error('Error al obtener usuarios:', error);
    throw new Error('No se pudieron obtener los usuarios');
  }
}

/**
 * Obtener un usuario por ID
 */
async function getUserById(id) {
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
}

/**
 * Actualizar un usuario
 */
async function updateUser(id, data) {
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
}

/**
 * Bloquear (ban) a un usuario
 */
async function banUser(id) {
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
}

module.exports = {
  getAllUsers,
  getUserById,
  updateUser,
  banUser,
};
