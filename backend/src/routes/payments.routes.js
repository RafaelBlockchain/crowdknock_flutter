const express = require('express');
const router = express.Router();

const paymentsController = require('../controllers/payments.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// 🔐 Proteger todas las rutas con autenticación
router.use(authMiddleware);

// ✅ Obtener todos los pagos (usuarios autenticados)
router.get('/', paymentsController.getAll);

// ✅ Crear un nuevo pago (solo admin)
router.post('/', roleMiddleware(['admin']), paymentsController.create);

module.exports = router;
