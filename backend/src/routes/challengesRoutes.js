const express = require('express');
const router = express.Router();

const challengesController = require('../controllers/challengesController');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// ✅ Obtener todos los desafíos (requiere estar autenticado)
router.get('/', authMiddleware, challengesController.getAllChallenges);

// ✅ Crear un nuevo desafío (solo admin)
router.post('/', authMiddleware, roleMiddleware('admin'), challengesController.createChallenge);

// ✅ Actualizar un desafío (solo admin)
router.put('/:id', authMiddleware, roleMiddleware('admin'), challengesController.updateChallenge);

// ✅ Eliminar un desafío (solo admin)
router.delete('/:id', authMiddleware, roleMiddleware('admin'), challengesController.deleteChallenge);

module.exports = router;
