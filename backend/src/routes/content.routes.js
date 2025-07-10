const express = require('express');
const router = express.Router();

const contentController = require('../controllers/content.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

const express = require('express');
const router = express.Router();

// Simulación de contenidos estáticos (puedes conectar a PostgreSQL más adelante)
const contents = [
  {
    id: "uuid1",
    title: "Bienvenidos a CrowdKnock",
    body: "Este es un espacio para compartir ideas.",
    type: "announcement",
    imageUrl: null,
    author: "admin",
    createdAt: "2025-07-10T12:00:00Z",
    updatedAt: null
  },
  {
    id: "uuid2",
    title: "Cómo participar en retos",
    body: "Paso 1: Revisa los retos disponibles...",
    type: "article",
    imageUrl: null,
    author: "admin",
    createdAt: "2025-07-11T14:00:00Z",
    updatedAt: null
  }
];

// GET /api/content → listado completo
router.get('/content', (req, res) => {
  res.json(contents);
});

// GET /api/content/:id → detalle
router.get('/content/:id', (req, res) => {
  const content = contents.find(c => c.id === req.params.id);
  if (!content) {
    return res.status(404).json({ message: 'Contenido no encontrado' });
  }
  res.json(content);
});

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
