const jwt = require('jsonwebtoken');
const { JWT_SECRET, JWT_EXPIRES_IN } = require('../config/env');

/**
 * Genera un token JWT para un usuario
 * @param {Object} payload - Información a codificar (ej: { id, email, role })
 * @param {String} expiresIn - Duración del token (por defecto: JWT_EXPIRES_IN o '1d')
 */
function generateToken(payload, expiresIn = JWT_EXPIRES_IN || '1d') {
  return jwt.sign(payload, JWT_SECRET, { expiresIn });
}

/**
 * Verifica un token y retorna su contenido si es válido
 * @param {String} token
 * @returns {Object} payload decodificado
 * @throws Error si el token es inválido o expirado
 */
function verifyToken(token) {
  return jwt.verify(token, JWT_SECRET);
}

/**
 * Extrae y verifica el token desde el header Authorization: Bearer ...
 * @param {Object} req - Objeto de la petición Express
 * @returns {Object|null} Payload del usuario si es válido, null si no hay token
 */
function extractUserFromHeader(req) {
  const authHeader = req.headers['authorization'];
  if (!authHeader || !authHeader.startsWith('Bearer ')) return null;

  const token = authHeader.split(' ')[1];
  try {
    return verifyToken(token);
  } catch (err) {
    return null;
  }
}

module.exports = {
  generateToken,
  verifyToken,
  extractUserFromHeader,
};

