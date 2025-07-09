const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const authMiddleware = require('../middlewares/authMiddleware');

// ✅ Registro de usuario
router.post('/register', authController.register);

// ✅ Login de usuario
router.post('/login', authController.login);

// ✅ Recuperación de contraseña
router.post('/reset-password', authController.resetPassword);

// ✅ Verificación de token (sin protección)
router.get('/verify', authController.verifyToken);

// ✅ Obtener datos del usuario autenticado (requiere JWT)
router.get('/me', authMiddleware, authController.getCurrentUser);

module.exports = router;
