const db = require('../config/db');
const { pick } = require('../utils/validation'); // Asegúrate de tener esta utilidad

// ✅ Obtener todos los desafíos
const getAllChallenges = async (req, res) => {
  try {
    const result = await db.query(`
      SELECT id, title, description, reward, status, created_at
      FROM challenges
      ORDER BY created_at DESC
    `);
    res.json({ success: true, data: result.rows });
  } catch (error) {
    console.error('Error al obtener desafíos:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

// ✅ Crear un nuevo desafío
const createChallenge = async (req, res) => {
  try {
    const fields = ['title', 'description', 'reward', 'status'];
    const data = pick(req.body, fields);

    const result = await db.query(
      `INSERT INTO challenges (title, description, reward, status, created_at)
       VALUES ($1, $2, $3, $4, NOW())
       RETURNING id, title, description, reward, status, created_at`,
      [data.title, data.description, data.reward, data.status]
    );

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Error al crear desafío:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

// ✅ Actualizar desafío
const updateChallenge = async (req, res) => {
  try {
    const fields = ['title', 'description', 'reward', 'status'];
    const data = pick(req.body, fields);
    const { id } = req.params;

    const result = await db.query(
      `UPDATE challenges
       SET title = $1, description = $2, reward = $3, status = $4
       WHERE id = $5
       RETURNING id`,
      [data.title, data.description, data.reward, data.status, id]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ success: false, error: 'Desafío no encontrado' });
    }

    res.json({ success: true, message: 'Desafío actualizado correctamente' });
  } catch (error) {
    console.error('Error al actualizar desafío:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

// ✅ Eliminar desafío
const deleteChallenge = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await db.query(`DELETE FROM challenges WHERE id = $1`, [id]);

    if (result.rowCount === 0) {
      return res.status(404).json({ success: false, error: 'Desafío no encontrado' });
    }

    res.json({ success: true, message: 'Desafío eliminado correctamente' });
  } catch (error) {
    console.error('Error al eliminar desafío:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

module.exports = {
  getAllChallenges,
  createChallenge,
  updateChallenge,
  deleteChallenge,
};
