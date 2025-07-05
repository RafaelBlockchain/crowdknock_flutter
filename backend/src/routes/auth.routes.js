const express = require('express');
const router = express.Router();

const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');
const authController = require('../controllers/auth.controller');


// Rutas públicas para autenticación y registro
router.post('/register', authController.register);
router.post('/login', authController.login);

// Ruta para verificar token JWT (opcional)
router.get('/verify-token', authController.verifyToken);


// Login de usuario
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    const result = await db.query('SELECT * FROM users WHERE email = $1', [email]);
    const user = result.rows[0];

    if (!user) {
      return res.status(401).json({ message: 'Credenciales inválidas' });
    }

    const passwordMatch = await bcrypt.compare(password, user.password_hash);
    if (!passwordMatch) {
      return res.status(401).json({ message: 'Contraseña incorrecta' });
    }

    const token = jwt.sign({ id: user.id, role: user.role }, process.env.JWT_SECRET, {
      expiresIn: '8h',
    });

    res.json({
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
      },
    });
  } catch (error) {
    console.error('Error en login:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

// Ruta protegida de verificación de token (opcional para frontend)
router.get('/verify', verifyToken, (req, res) => {
  res.json({ message: 'Token válido', user: req.user });
});

module.exports = router;

