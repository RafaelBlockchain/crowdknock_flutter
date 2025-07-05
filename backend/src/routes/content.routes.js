const express = require('express');
const router = express.Router();

const contentController = require('../controllers/contentController');
const { verifyToken } = require('../middleware/auth');

// Obtener todo el contenido
router.get('/', verifyToken, contentController.getAllContent);

// Crear nuevo contenido
router.post('/', verifyToken, contentController.createContent);

// Actualizar contenido
router.put('/:id', verifyToken, contentController.updateContent);

// Eliminar contenido
router.delete('/:id', verifyToken, contentController.deleteContent);

module.exports = router;

