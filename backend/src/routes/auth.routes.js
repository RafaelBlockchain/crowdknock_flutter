const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const { body } = require('express-validator');
const { validateRequest } = require('../middlewares/validationMiddleware');


// ✅ Registro de usuario
router.post('/register', authController.register);

// ✅ Login de usuario
router.post(
  '/login',
  [
    body('email').isEmail().withMessage('Email inválido'),
    body('password').notEmpty().withMessage('La contraseña es obligatoria')
  ],
  validateRequest,
  authController.login
);

router.post(
  '/register',
  [
    body('email').isEmail().withMessage('Email inválido'),
    body('password').isLength({ min: 6 }).withMessage('Mínimo 6 caracteres'),
    body('name').notEmpty().withMessage('El nombre es obligatorio')
  ],
  validateRequest,
  authController.register
);


// ✅ Recuperación de contraseña
router.post('/reset-password', authController.resetPassword);

// ✅ Verificación de token (sin protección)
router.get('/verify', authController.verifyToken);

// ✅ Obtener datos del usuario autenticado (requiere JWT)
router.get('/me', authMiddleware, authController.getCurrentUser);

module.exports = router;
