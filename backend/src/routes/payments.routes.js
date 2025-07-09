const express = require('express');
const router = express.Router();

const paymentsController = require('../controllers/payments.controller');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

// ✅ Obtener todos los pagos (autenticado)
router.get('/', authMiddleware, paymentsController.getAll);

// ✅ Crear nuevo pago (solo admin)
router.post('/', authMiddleware, roleMiddleware(['admin']), paymentsController.create);

module.exports = router;
