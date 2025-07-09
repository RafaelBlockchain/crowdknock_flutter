const express = require('express');
const router = express.Router();

const contentController = require('../controllers/content.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// ✅ Obtener todo el contenido (requiere autenticación)
router.get('/', authMiddleware, contentController.getAllContent);

// ✅ Crear nuevo contenido (solo admin)
router.post('/', authMiddleware, roleMiddleware(['admin']), contentController.createContent);

// ✅ Actualizar contenido (solo admin)
router.put('/:id', authMiddleware, roleMiddleware(['admin']), contentController.updateContent);

// ✅ Eliminar contenido (solo admin)
router.delete('/:id', authMiddleware, roleMiddleware(['admin']), contentController.deleteContent);

module.exports = router;
