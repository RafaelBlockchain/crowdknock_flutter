const express = require('express');
const router = express.Router();

const usersController = require('../controllers/usersController');
const authMiddleware = require('../middleware/auth');

// ✅ protección con middleware
router.get('/', authMiddleware, controller.handler);
router.post('/', authMiddleware, roleMiddleware(['admin']), controller.handler);

// Todas las rutas están protegidas con JWT
router.use(authMiddleware.verifyToken);

// GET /api/users
router.get('/', usersController.getAllUsers);

// PUT /api/users/:id
router.put('/:id', usersController.updateUser);

// POST /api/users/:id/ban
router.post('/:id/ban', usersController.banUser);

module.exports = router;
