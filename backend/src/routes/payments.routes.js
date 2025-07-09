const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/auth');

// ✅ protección con middleware
router.get('/', authMiddleware, controller.handler);
router.post('/', authMiddleware, roleMiddleware(['admin']), controller.handler);

// Controlador simulado (puedes mover esto a un archivo separado si lo deseas)
const paymentsController = {
  getAll: async (req, res) => {
    try {
      // Simulación de pagos (puede conectarse a Stripe, base de datos, etc.)
      const payments = [
        { id: 1, user: 'Usuario1', amount: 29.99, method: 'card', status: 'completed', date: '2025-07-01' },
        { id: 2, user: 'Usuario2', amount: 9.99, method: 'paypal', status: 'pending', date: '2025-07-02' }
      ];
      res.json(payments);
    } catch (error) {
      console.error('Error fetching payments:', error);
      res.status(500).json({ error: 'Error fetching payments' });
    }
  },

  create: async (req, res) => {
    try {
      const { userId, amount, method } = req.body;
      // Aquí se insertaría en la base de datos o se iniciaría un proceso de pago.
      res.status(201).json({
        message: 'Pago registrado exitosamente',
        data: { id: 3, userId, amount, method, status: 'pending', date: new Date() }
      });
    } catch (error) {
      console.error('Error creando pago:', error);
      res.status(500).json({ error: 'Error creando pago' });
    }
  }
};

// Rutas protegidas
router.get('/', authMiddleware, paymentsController.getAll);
router.post('/', authMiddleware, paymentsController.create);

module.exports = router;

