const express = require('express');
const router = express.Router();

const challengesController = require('../controllers/challenges.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// Middleware base: autenticación requerida para todas las rutas de desafíos
router.use(authMiddleware);

// ✅ Obtener todos los desafíos (usuarios autenticados)
router.get('/', challengesController.getAllChallenges);

// ✅ Crear desafío (solo admin)
router.post('/', roleMiddleware('admin'), challengesController.createChallenge);

// ✅ Actualizar desafío por ID (solo admin)
router.put('/:id', roleMiddleware('admin'), challengesController.updateChallenge);

// ✅ Eliminar desafío por ID (solo admin)
router.delete('/:id', roleMiddleware('admin'), challengesController.deleteChallenge);

module.exports = router;
