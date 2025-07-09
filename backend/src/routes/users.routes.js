const express = require('express');
const router = express.Router();

const usersController = require('../controllers/usersController');
const { verifyToken } = require('../middleware/auth');

// ✅ protección con middleware
router.get('/', authMiddleware, controller.handler);
router.post('/', authMiddleware, roleMiddleware(['admin']), controller.handler);

// Obtener todos los usuarios
router.get('/', verifyToken, usersController.getAllUsers);

// Actualizar datos de un usuario
router.put('/:id', verifyToken, usersController.updateUser);

// Banear usuario
router.patch('/:id/ban', verifyToken, usersController.banUser);

module.exports = router;

