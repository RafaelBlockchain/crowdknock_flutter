const express = require('express');
const router = express.Router();

const usersController = require('../controllers/users.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// 🔐 Todas las rutas requieren autenticación
router.use(authMiddleware);

// ✅ Obtener todos los usuarios (solo admin)
router.get('/', roleMiddleware(['admin']), usersController.getAllUsers);

// ✅ Actualizar datos de un usuario por ID (solo admin)
router.put('/:id', roleMiddleware(['admin']), usersController.updateUser);

// ✅ Banear usuario por ID (solo admin)
router.post('/:id/ban', roleMiddleware(['admin']), usersController.banUser);

module.exports = router;
