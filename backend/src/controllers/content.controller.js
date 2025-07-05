const db = require('../config/db');

// Obtener lista de contenido
const getAllContent = async (req, res) => {
  try {
    const result = await db.query(`
      SELECT id, title, type, status, created_at
      FROM contents
      ORDER BY created_at DESC
    `);
    res.json(result.rows);
  } catch (error) {
    console.error('Error al obtener contenidos:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Crear nuevo contenido
const createContent = async (req, res) => {
  const { title, type, status } = req.body;
  try {
    const result = await db.query(
      `INSERT INTO contents (title, type, status, created_at)
       VALUES ($1, $2, $3, NOW()) RETURNING *`,
      [title, type, status]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Error al crear contenido:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Editar contenido
const updateContent = async (req, res) => {
  const { id } = req.params;
  const { title, type, status } = req.body;
  try {
    await db.query(
      `UPDATE contents
       SET title = $1, type = $2, status = $3
       WHERE id = $4`,
      [title, type, status, id]
    );
    res.json({ message: 'Contenido actualizado correctamente' });
  } catch (error) {
    console.error('Error al actualizar contenido:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

// Eliminar contenido
const deleteContent = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query(`DELETE FROM contents WHERE id = $1`, [id]);
    res.json({ message: 'Contenido eliminado correctamente' });
  } catch (error) {
    console.error('Error al eliminar contenido:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

module.exports = {
  getAllContent,
  createContent,
  updateContent,
  deleteContent,
};

