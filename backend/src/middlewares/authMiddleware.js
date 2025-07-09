// backend/src/middlewares/authMiddleware.js

const { verifyToken } = require('../utils/jwt');

function authMiddleware(req, res, next) {
  const authHeader = req.headers['authorization'];

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ success: false, error: 'Token no proporcionado' });
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = verifyToken(token);
    req.user = decoded; // Agrega los datos del usuario a la request
    next();
  } catch (err) {
    console.error('Error en authMiddleware:', err);
    return res.status(401).json({ success: false, error: 'Token inválido o expirado' });
  }
}

module.exports = authMiddleware;
