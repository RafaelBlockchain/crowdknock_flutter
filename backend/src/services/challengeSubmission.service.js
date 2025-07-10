const db = require('../../config/db'); // conexión pg
const path = require('path');

async function createSubmission({ userId, challengeId, comment, filePath }) {
  const query = `
    INSERT INTO challenge_submissions (user_id, challenge_id, comment, file_path)
    VALUES ($1, $2, $3, $4)
    RETURNING *;
  `;
  const values = [userId, challengeId, comment, filePath];

  const { rows } = await db.query(query, values);
  return rows[0];
}

module.exports = {
  createSubmission,
};
