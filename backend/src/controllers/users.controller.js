const userService = require('../services/users.service');

exports.getAllUsers = async (req, res, next) => {
  try {
    const users = await userService.getAll();
    res.json({ success: true, data: users });
  } catch (error) {
    console.error('Error al obtener usuarios:', error);
    next(error);
  }
};

exports.updateUser = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { name, email, role } = req.body;

    if (!name && !email && !role) {
      return res.status(400).json({
        success: false,
        error: 'Debe proporcionar al menos un campo a actualizar',
      });
    }

    const updated = await userService.update(id, { name, email, role });

    if (!updated) {
      return res.status(404).json({ success: false, error: 'Usuario no encontrado' });
    }

    res.json({ success: true, message: 'Usuario actualizado correctamente' });
  } catch (error) {
    console.error('Error al actualizar usuario:', error);
    next(error);
  }
};

exports.banUser = async (req, res, next) => {
  try {
    const { id } = req.params;

    const success = await userService.ban(id);
    if (!success) {
      return res.status(404).json({ success: false, error: 'Usuario no encontrado' });
    }

    res.json({ success: true, message: 'Usuario bloqueado correctamente' });
  } catch (error) {
    console.error('Error al bloquear usuario:', error);
    next(error);
  }
};
