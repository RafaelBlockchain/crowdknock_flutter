const UserService = require('../services/UserService');

const getAllUsers = async (req, res, next) => {
  try {
    const users = await UserService.getAllUsers();
    res.json({ success: true, data: users });
  } catch (err) {
    console.error('Error al obtener usuarios:', err);
    next(err);
  }
};

const updateUser = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { name, email, role } = req.body;

    if (!name && !email && !role) {
      return res.status(400).json({ success: false, error: 'Debe proporcionar al menos un campo a actualizar' });
    }

    const updated = await UserService.updateUser(id, { name, email, role });

    if (!updated) {
      return res.status(404).json({ success: false, error: 'Usuario no encontrado' });
    }

    res.json({ success: true, message: 'Usuario actualizado correctamente' });
  } catch (err) {
    console.error('Error al actualizar usuario:', err);
    next(err);
  }
};

const banUser = async (req, res, next) => {
  try {
    const { id } = req.params;

    const success = await UserService.banUser(id);
    if (!success) {
      return res.status(404).json({ success: false, error: 'Usuario no encontrado' });
    }

    res.json({ success: true, message: 'Usuario bloqueado correctamente' });
  } catch (err) {
    console.error('Error al bloquear usuario:', err);
    next(err);
  }
};

module.exports = {
  getAllUsers,
  updateUser,
  banUser,
};
