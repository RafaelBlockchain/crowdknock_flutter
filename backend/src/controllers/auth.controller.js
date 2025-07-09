const bcrypt = require('bcryptjs');
const db = require('../config/db');
const { User } = require('../models');
const { sendEmail } = require('../utils/email');
const { generateToken, verifyToken } = require('../utils/jwt');
const {
  validateEmail,
  validatePassword,
  validateRequired,
} = require('../utils/validation');

const authController = {
  // ✅ Registro de usuario
  register: async (req, res) => {
    try {
      const { email, password, name } = req.body;

      if (!validateRequired(email) || !validateEmail(email)) {
        return res.status(400).json({ success: false, error: 'Email inválido' });
      }

      if (!validateRequired(password) || !validatePassword(password)) {
        return res.status(400).json({ success: false, error: 'Contraseña inválida' });
      }

      if (!validateRequired(name)) {
        return res.status(400).json({ success: false, error: 'Nombre requerido' });
      }

      const existingUser = await db.oneOrNone('SELECT * FROM users WHERE email = $1', [email]);
      if (existingUser) {
        return res.status(409).json({ success: false, error: 'El usuario ya existe' });
      }

      const hashedPassword = await bcrypt.hash(password, 10);
      const newUser = await db.one(
        `INSERT INTO users (email, password, name, role)
         VALUES ($1, $2, $3, 'user')
         RETURNING id, email, name, role`,
        [email, hashedPassword, name]
      );

      const token = generateToken(newUser);
      res.status(201).json({ success: true, data: { token, user: newUser } });

    } catch (error) {
      console.error('Error al registrar usuario:', error);
      res.status(500).json({ success: false, error: 'Error interno del servidor' });
    }
  },

  // ✅ Login
  login: async (req, res) => {
    try {
      const { email, password } = req.body;

      if (!validateRequired(email) || !validateEmail(email)) {
        return res.status(400).json({ success: false, error: 'Email inválido' });
      }

      if (!validateRequired(password)) {
        return res.status(400).json({ success: false, error: 'Contraseña requerida' });
      }

      const user = await db.oneOrNone('SELECT * FROM users WHERE email = $1', [email]);
      if (!user) {
        return res.status(401).json({ success: false, error: 'Credenciales inválidas' });
      }

      const valid = await bcrypt.compare(password, user.password);
      if (!valid) {
        return res.status(401).json({ success: false, error: 'Credenciales inválidas' });
      }

      const { password: _, ...userWithoutPassword } = user;
      const token = generateToken(userWithoutPassword);
      res.json({ success: true, data: { token, user: userWithoutPassword } });

    } catch (error) {
      console.error('Error al iniciar sesión:', error);
      res.status(500).json({ success: false, error: 'Error interno del servidor' });
    }
  },

  // ✅ Verificación de token manual
  verifyToken: async (req, res) => {
    try {
      const authHeader = req.headers['authorization'];
      if (!authHeader) return res.status(401).json({ success: false, error: 'Token no proporcionado' });

      const token = authHeader.split(' ')[1];
      const decoded = verifyToken(token);
      res.json({ success: true, data: { valid: true, user: decoded } });

    } catch (error) {
      console.error('Token inválido:', error);
      res.status(401).json({ success: false, error: 'Token inválido o expirado' });
    }
  },

  // ✅ Solicitud de recuperación
  resetPasswordRequest: async (req, res) => {
    try {
      const { email } = req.body;

      if (!email) {
        return res.status(400).json({ message: 'El email es requerido' });
      }

      const user = await User.findOne({ where: { email } });

      if (!user) {
        return res.status(404).json({ message: 'Usuario no encontrado' });
      }

      const token = generateToken({ id: user.id }, '1h');
      const resetLink = `https://frontend.crowdknock.com/reset-password?token=${token}`;

      await sendEmail({
        to: user.email,
        subject: 'Recuperación de contraseña - CrowdKnock',
        html: `
          <h2>Hola ${user.name}</h2>
          <p>Haz clic en el siguiente enlace para restablecer tu contraseña:</p>
          <a href="${resetLink}" target="_blank">${resetLink}</a>
          <p>Este enlace es válido por 1 hora.</p>
        `,
      });

      res.json({ message: 'Correo de recuperación enviado' });
    } catch (error) {
      console.error('Error en resetPasswordRequest:', error);
      res.status(500).json({ message: 'Error interno del servidor' });
    }
  },

  // ✅ Confirmación de reseteo
  resetPassword: async (req, res) => {
    try {
      const { token, password } = req.body;

      if (!token || !password) {
        return res.status(400).json({ success: false, error: 'Token y contraseña son requeridos' });
      }

      const decoded = verifyToken(token);
      const userId = decoded.id;

      const user = await User.findByPk(userId);
      if (!user) {
        return res.status(404).json({ success: false, error: 'Usuario no encontrado' });
      }

      const hashedPassword = await bcrypt.hash(password, 10);
      user.password = hashedPassword;
      await user.save();

      res.json({ success: true, message: 'Contraseña actualizada correctamente' });
    } catch (error) {
      console.error('Error en resetPassword:', error);
      res.status(400).json({ success: false, error: 'Token inválido o expirado' });
    }
  },

  // ✅ Obtener usuario actual
  getCurrentUser: async (req, res, next) => {
    try {
      const userId = req.user?.id;
      if (!userId) {
        return res.status(401).json({ success: false, error: 'Token inválido o expirado' });
      }

      const user = await User.findByPk(userId);
      if (!user) {
        return res.status(404).json({ success: false, error: 'Usuario no encontrado' });
      }

      const { id, name, email, role } = user;
      res.json({ success: true, data: { id, name, email, role } });
    } catch (error) {
      next(error);
    }
  },
};

module.exports = authController;
