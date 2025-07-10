const db = require('../config/db');
const { pick } = require('../utils/validation');
const db = require('../../config/db');

async function getAllContent() {
  const query = 'SELECT * FROM contents ORDER BY created_at DESC';
  const { rows } = await db.query(query);
  return rows;
}

async function getContentById(id) {
  const query = 'SELECT * FROM contents WHERE id = $1';
  const { rows } = await db.query(query, [id]);
  return rows[0];
}

module.exports = {
  getAllContent,
  getContentById,
};


exports.getAll = async () => {
  const result = await db.query(`
    SELECT id, title, description, type, url, created_at
    FROM contents
    ORDER BY created_at DESC
  `);
  return result.rows;
};

exports.create = async (data) => {
  const fields = ['title', 'description', 'type', 'url'];
  const content = pick(data, fields);

  const result = await db.query(
    `INSERT INTO contents (title, description, type, url, created_at)
     VALUES ($1, $2, $3, $4, NOW())
     RETURNING id, title, description, type, url, created_at`,
    [content.title, content.description, content.type, content.url]
  );

  return result.rows[0];
};

exports.update = async (id, updates) => {
  const fields = ['title', 'description', 'type', 'url'];
  const data = pick(updates, fields);

  const result = await db.query(
    `UPDATE contents
     SET title = $1, description = $2, type = $3, url = $4
     WHERE id = $5
     RETURNING id`,
    [data.title, data.description, data.type, data.url, id]
  );

  if (result.rowCount === 0) {
    const error = new Error('Contenido no encontrado');
    error.status = 404;
    throw error;
  }

  return { message: 'Contenido actualizado correctamente' };
};

exports.remove = async (id) => {
  const result = await db.query(
    `DELETE FROM contents WHERE id = $1`,
    [id]
  );

  if (result.rowCount === 0) {
    const error = new Error('Contenido no encontrado');
    error.status = 404;
    throw error;
  }

  return { message: 'Contenido eliminado correctamente' };
};
