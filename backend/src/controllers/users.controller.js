const db = require('../config/db');

// Obtener todos los usuarios
exports.getAllUsers = async (req, res) => {
  try {
    const result = await db.query('SELECT id, name, email, role, banned FROM users ORDER BY created_at DESC');
    res.json(result.rows);
  } catch (err) {
    console.error('Error al obtener usuarios:', err);
    res.status(500).json({ message: 'Error del servidor' });
  }
};

// Actualizar nombre y rol de un usuario
exports.updateUser = async (req, res) => {
  const userId = req.params.id;
  const { name, role } = req.body;

  try {
    const result = await db.query(
      'UPDATE users SET name = $1, role = $2 WHERE id = $3 RETURNING *',
      [name, role, userId]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error('Error al actualizar usuario:', err);
    res.status(500).json({ message: 'Error del servidor' });
  }
};

// Banear a un usuario
exports.banUser = async (req, res) => {
  const userId = req.params.id;

  try {
    const result = await db.query(
      'UPDATE users SET banned = true WHERE id = $1 RETURNING *',
      [userId]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    res.json({ message: 'Usuario baneado exitosamente' });
  } catch (err) {
    console.error('Error al banear usuario:', err);
    res.status(500).json({ message: 'Error del servidor' });
  }
};

