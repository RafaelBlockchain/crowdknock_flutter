const db = require('../config/db');

const paymentsController = {
  // Obtener todos los pagos
  getAllPayments: async (req, res) => {
    try {
      const payments = await db.any(`
        SELECT id, user_id, amount, status, method, created_at
        FROM payments
        ORDER BY created_at DESC
      `);
      res.json(payments);
    } catch (error) {
      console.error('Error al obtener pagos:', error);
      res.status(500).json({ error: 'Error al obtener pagos' });
    }
  },

  // Crear un nuevo pago
  createPayment: async (req, res) => {
    try {
      const { user_id, amount, method, status } = req.body;
      const newPayment = await db.one(
        `INSERT INTO payments (user_id, amount, method, status)
         VALUES ($1, $2, $3, $4)
         RETURNING id, user_id, amount, status, method, created_at`,
        [user_id, amount, method, status || 'pending']
      );
      res.status(201).json(newPayment);
    } catch (error) {
      console.error('Error al crear pago:', error);
      res.status(500).json({ error: 'Error al crear pago' });
    }
  },

  // Actualizar el estado de un pago
  updatePaymentStatus: async (req, res) => {
    try {
      const { id } = req.params;
      const { status } = req.body;

      await db.none(
        `UPDATE payments
         SET status = $1
         WHERE id = $2`,
        [status, id]
      );

      res.json({ success: true });
    } catch (error) {
      console.error('Error al actualizar estado del pago:', error);
      res.status(500).json({ error: 'Error al actualizar estado del pago' });
    }
  },

  // Obtener pagos por usuario
  getPaymentsByUser: async (req, res) => {
    try {
      const { userId } = req.params;
      const payments = await db.any(
        `SELECT id, amount, status, method, created_at
         FROM payments
         WHERE user_id = $1
         ORDER BY created_at DESC`,
        [userId]
      );
      res.json(payments);
    } catch (error) {
      console.error('Error al obtener pagos por usuario:', error);
      res.status(500).json({ error: 'Error al obtener pagos por usuario' });
    }
  }
};

module.exports = paymentsController;

