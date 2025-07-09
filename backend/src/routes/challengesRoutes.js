const express = require('express');
const router = express.Router();

const challengesController = require('../controllers/challengesController');
const { verifyToken } = require('../middleware/auth');

// ✅ protección con middleware
router.get('/', authMiddleware, controller.handler);
router.post('/', authMiddleware, roleMiddleware(['admin']), controller.handler);

// Obtener todos los desafíos
router.get('/', verifyToken, challengesController.getAllChallenges);

// Crear un nuevo desafío
router.post('/', verifyToken, challengesController.createChallenge);

// Actualizar un desafío
router.put('/:id', verifyToken, challengesController.updateChallenge);

// Eliminar un desafío
router.delete('/:id', verifyToken, challengesController.deleteChallenge);

module.exports = router; 
