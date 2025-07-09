const express = require('express');
const router = express.Router();
const { body } = require('express-validator');

const authController = require('../controllers/auth.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');
const { validateRequest } = require('../middlewares/validationMiddleware');
const { loginRateLimiter } = require('../middlewares/rateLimiter');

// ✅ Registro de usuario
router.post(
  '/register',
  [
    body('email').isEmail().withMessage('Email inválido'),
    body('password').isLength({ min: 6 }).withMessage('Mínimo 6 caracteres'),
    body('name').notEmpty().withMessage('El nombre es obligatorio'),
  ],
  validateRequest,
  authController.register
);

// ✅ Login con protección contra fuerza bruta
router.post(
  '/login',
  loginRateLimiter,
  [
    body('email').isEmail().withMessage('Email inválido'),
    body('password').notEmpty().withMessage('La contraseña es obligatoria'),
  ],
  validateRequest,
  authController.login
);

// ✅ Solicitud de recuperación de contraseña
router.post(
  '/reset-request',
  [body('email').isEmail().withMessage('Email inválido')],
  validateRequest,
  authController.resetPasswordRequest
);

// ✅ Confirmar reseteo con token
router.post(
  '/reset-password',
  [
    body('token').notEmpty().withMessage('Token requerido'),
    body('password').isLength({ min: 6 }).withMessage('Nueva contraseña inválida'),
  ],
  validateRequest,
  authController.resetPassword
);

// ✅ Verificación de token manual
router.get('/verify', authController.verifyToken);

// ✅ Obtener datos del usuario autenticado
router.get('/me', authMiddleware, authController.getCurrentUser);

module.exports = router;
