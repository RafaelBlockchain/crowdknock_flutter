const express = require('express');
const router = express.Router();

const usersController = require('../controllers/users.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// ✅ Proteger todas las rutas
router.use(authMiddleware);

// ✅ Obtener todos los usuarios (requiere admin)
router.get('/', roleMiddleware(['admin']), usersController.getAllUsers);

// ✅ Actualizar un usuario (requiere admin)
router.put('/:id', roleMiddleware(['admin']), usersController.updateUser);

// ✅ Banear un usuario (requiere admin)
router.post('/:id/ban', roleMiddleware(['admin']), usersController.banUser);

module.exports = router;
