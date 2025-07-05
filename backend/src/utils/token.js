// backend/src/utils/token.js
const jwt = require('jsonwebtoken');
const { JWT_SECRET, JWT_EXPIRES_IN = '1h' } = process.env;

/**
 * Genera un token JWT firmado con el payload del usuario.
 * @param {Object} userPayload - Objeto con datos del usuario para incluir en el token (id, name, role, email).
 * @returns {string} Token JWT firmado
 */
function generateToken(userPayload) {
  // No incluir información sensible como password en el payload
  return jwt.sign(userPayload, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });
}

module.exports = { generateToken };
