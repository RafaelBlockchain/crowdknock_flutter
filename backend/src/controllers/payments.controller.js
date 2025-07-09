const paymentService = require('../services/payments.service');

exports.getAllPayments = async (req, res) => {
  try {
    const payments = await paymentService.getAll();
    res.json({ success: true, data: payments });
  } catch (error) {
    console.error('Error al obtener pagos:', error);
    res.status(500).json({ success: false, error: 'Error al obtener pagos' });
  }
};

exports.createPayment = async (req, res) => {
  try {
    const { user_id, amount, method, status } = req.body;

    if (!user_id || !amount || !method) {
      return res.status(400).json({
        success: false,
        error: 'Campos requeridos: user_id, amount, method',
      });
    }

    const newPayment = await paymentService.create({
      user_id,
      amount,
      method,
      status: status || 'pending',
    });

    res.status(201).json({ success: true, data: newPayment });
  } catch (error) {
    console.error('Error al crear pago:', error);
    res.status(500).json({ success: false, error: 'Error al crear pago' });
  }
};

exports.updatePaymentStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    if (!status) {
      return res.status(400).json({ success: false, error: 'El campo status es requerido' });
    }

    const updated = await paymentService.updateStatus(id, status);

    if (!updated) {
      return res.status(404).json({ success: false, error: 'Pago no encontrado' });
    }

    res.json({ success: true, message: 'Estado del pago actualizado' });
  } catch (error) {
    console.error('Error al actualizar estado del pago:', error);
    res.status(500).json({ success: false, error: 'Error al actualizar estado del pago' });
  }
};

exports.getPaymentsByUser = async (req, res) => {
  try {
    const { userId } = req.params;
    const payments = await paymentService.getByUser(userId);
    res.json({ success: true, data: payments });
  } catch (error) {
    console.error('Error al obtener pagos por usuario:', error);
    res.status(500).json({ success: false, error: 'Error al obtener pagos por usuario' });
  }
};

