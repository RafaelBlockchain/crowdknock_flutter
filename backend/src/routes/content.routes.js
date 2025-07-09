const express = require('express');
const router = express.Router();

const contentController = require('../controllers/content.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// 🔐 Proteger todas las rutas con autenticación
router.use(authMiddleware);

// ✅ Obtener todo el contenido (usuarios autenticados)
router.get('/', contentController.getAllContent);

// ✅ Crear nuevo contenido (solo admin)
router.post('/', roleMiddleware(['admin']), contentController.createContent);

// ✅ Actualizar contenido (solo admin)
router.put('/:id', roleMiddleware(['admin']), contentController.updateContent);

// ✅ Eliminar contenido (solo admin)
router.delete('/:id', roleMiddleware(['admin']), contentController.deleteContent);

module.exports = router;
