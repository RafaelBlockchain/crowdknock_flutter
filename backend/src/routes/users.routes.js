const express = require('express');
const router = express.Router();

const usersController = require('../controllers/users.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// ✅ Proteger todas las rutas con JWT
router.use(authMiddleware);

// ✅ Obtener todos los usuarios (solo admin)
router.get('/', roleMiddleware(['admin']), usersController.getAllUsers);

// ✅ Actualizar datos de un usuario (solo admin)
router.put('/:id', roleMiddleware(['admin']), usersController.updateUser);

// ✅ Banear usuario (solo admin)
router.patch('/:id/ban', roleMiddleware(['admin']), usersController.banUser);

module.exports = router;
