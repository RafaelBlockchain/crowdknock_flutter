const db = require('../config/db');

// Obtener todos los desafíos
const getAllChallenges = async (req, res) => {
  try {
    const result = await db.query(`
      SELECT id, title, description, reward, status, created_at
      FROM challenges
      ORDER BY created_at DESC
    `);
    res.json(result.rows);
  } catch (error) {
    console.error('Error al obtener desafíos:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Crear un nuevo desafío
const createChallenge = async (req, res) => {
  const { title, description, reward, status } = req.body;
  try {
    const result = await db.query(
      `INSERT INTO challenges (title, description, reward, status, created_at)
       VALUES ($1, $2, $3, $4, NOW()) RETURNING *`,
      [title, description, reward, status]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Error al crear desafío:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Actualizar desafío
const updateChallenge = async (req, res) => {
  const { id } = req.params;
  const { title, description, reward, status } = req.body;
  try {
    await db.query(
      `UPDATE challenges
       SET title = $1, description = $2, reward = $3, status = $4
       WHERE id = $5`,
      [title, description, reward, status, id]
    );
    res.json({ message: 'Desafío actualizado correctamente' });
  } catch (error) {
    console.error('Error al actualizar desafío:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Eliminar desafío
const deleteChallenge = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query(`DELETE FROM challenges WHERE id = $1`, [id]);
    res.json({ message: 'Desafío eliminado correctamente' });
  } catch (error) {
    console.error('Error al eliminar desafío:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

module.exports = {
  getAllChallenges,
  createChallenge,
  updateChallenge,
  deleteChallenge,
};
