// backend/src/middlewares/authMiddleware.js

const jwt = require('jsonwebtoken');
const { JWT_SECRET } = process.env;

function authMiddleware(req, res, next) {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ success: false, error: 'Token no proporcionado' });
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    // Aquí asignamos la info del usuario al request para usar en otros middlewares o rutas
    req.user = {
      id: decoded.id,
      name: decoded.name,
      role: decoded.role,
      email: decoded.email,
    };
    next();
  } catch (error) {
    return res.status(401).json({ success: false, error: 'Token inválido o expirado' });
  }
}

module.exports = authMiddleware;

