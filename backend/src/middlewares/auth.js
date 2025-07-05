const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');

dotenv.config();

const JWT_SECRET = process.env.JWT_SECRET || 'clave-secreta-predeterminada';

exports.verifyToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'Token no proporcionado' });
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded; // Puedes acceder a los datos del usuario desde aquí
    next();
  } catch (err) {
    console.error('Error de autenticación:', err.message);
    return res.status(403).json({ message: 'Token inválido o expirado' });
  }
};
