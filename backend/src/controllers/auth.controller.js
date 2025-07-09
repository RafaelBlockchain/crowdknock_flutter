const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../config/db');
const { JWT_SECRET, JWT_EXPIRES_IN } = require('../config/env');
const { User } = require('../models');

// 🔐 Generar token JWT
function generateToken(user) {
  return jwt.sign(
    { id: user.id, email: user.email, role: user.role },
    JWT_SECRET,
    { expiresIn: JWT_EXPIRES_IN || '1d' }
  );
}

const {
  validateEmail,
  validatePassword,
  validateRequired,
} = require('../utils/validation');

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (!validateRequired(email) || !validateEmail(email)) {
      return res.status(400).json({ error: 'Email inválido' });
    }

    if (!validateRequired(password) || !validatePassword(password)) {
      return res.status(400).json({ error: 'Contraseña inválida' });
    }

    // lógica de login...

  } catch (err) {
    next(err);
  }
};


const authController = {
  // ✅ Registro de usuario
  register: async (req, res) => {
    try {
      const { email, password, name } = req.body;

      if (!email || !password || !name) {
        return res.status(400).json({ error: 'Nombre, email y contraseña son requeridos' });
      }

      const existingUser = await db.oneOrNone('SELECT * FROM users WHERE email = $1', [email]);
      if (existingUser) {
        return res.status(409).json({ error: 'El usuario ya existe' });
      }

      const hashedPassword = await bcrypt.hash(password, 10);
      const newUser = await db.one(
        `INSERT INTO users (email, password, name, role)
         VALUES ($1, $2, $3, 'user')
         RETURNING id, email, name, role`,
        [email, hashedPassword, name]
      );

      const token = generateToken(newUser);
      res.status(201).json({ token, user: newUser });

    } catch (error) {
      console.error('Error al registrar usuario:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  },

  // ✅ Login
  login: async (req, res) => {
    try {
      const { email, password } = req.body;

      if (!email || !password) {
        return res.status(400).json({ error: 'Email y contraseña son requeridos' });
      }

      const user = await db.oneOrNone('SELECT * FROM users WHERE email = $1', [email]);
      if (!user) {
        return res.status(401).json({ error: 'Credenciales inválidas' });
      }

      const valid = await bcrypt.compare(password, user.password);
      if (!valid) {
        return res.status(401).json({ error: 'Credenciales inválidas' });
      }

      const { password: _, ...userWithoutPassword } = user;
      const token = generateToken(userWithoutPassword);
      res.json({ token, user: userWithoutPassword });

    } catch (error) {
      console.error('Error al iniciar sesión:', error);
      res.status(500).json({ error: 'Error interno del servidor' });
    }
  },

  // ✅ Verificación de token
  verifyToken: async (req, res) => {
    try {
      const authHeader = req.headers['authorization'];
      if (!authHeader) return res.status(401).json({ error: 'Token no proporcionado' });

      const token = authHeader.split(' ')[1];
      const decoded = jwt.verify(token, JWT_SECRET);
      res.json({ valid: true, user: decoded });

    } catch (error) {
      console.error('Token inválido:', error);
      res.status(401).json({ valid: false, error: 'Token inválido o expirado' });
    }
  },

  // ✅ Recuperación de contraseña
  resetPassword: async (req, res) => {
    try {
      const { token, password } = req.body;

      if (!token || !password) {
        return res.status(400).json({ message: 'Token y contraseña son requeridos' });
      }

      const decoded = jwt.verify(token, JWT_SECRET);
      const userId = decoded.id;

      const user = await User.findByPk(userId);
      if (!user) {
        return res.status(404).json({ message: 'Usuario no encontrado' });
      }

      const hashedPassword = await bcrypt.hash(password, 10);
      user.password = hashedPassword;
      await user.save();

      res.json({ message: 'Contraseña actualizada correctamente' });
    } catch (error) {
      console.error('Error en resetPassword:', error);
      res.status(400).json({ message: 'Token inválido o expirado' });
    }
  },

  // ✅ Obtener datos del usuario autenticado
  getCurrentUser: async (req, res, next) => {
    try {
      const userId = req.user?.id;
      if (!userId) {
        return res.status(401).json({ message: 'Token inválido o expirado' });
      }

      const user = await User.findByPk(userId);
      if (!user) {
        return res.status(404).json({ message: 'Usuario no encontrado' });
      }

      const { id, name, email, role } = user;
      res.json({ user: { id, name, email, role } });
    } catch (error) {
      next(error);
    }
  }
};

module.exports = authController;

