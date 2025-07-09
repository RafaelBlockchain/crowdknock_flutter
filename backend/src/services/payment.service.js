const { Payment, User } = require('../models');

/**
 * Obtener todos los pagos con datos del usuario asociado
 */
exports.getAll = async () => {
  try {
    return await Payment.findAll({
      include: [
        {
          model: User,
          attributes: ['id', 'name', 'email'],
        },
      ],
      order: [['createdAt', 'DESC']],
    });
  } catch (error) {
    console.error('Error al obtener pagos:', error);
    throw new Error('No se pudieron obtener los pagos');
  }
};

/**
 * Crear un nuevo pago
 * @param {Object} data - Datos del pago
 */
exports.create = async (data) => {
  try {
    const { userId, amount, method, status } = data;

    if (!userId || !amount || isNaN(amount)) {
      throw new Error('Datos de pago inválidos');
    }

    return await Payment.create({
      userId,
      amount,
      method: method || 'manual',
      status: status || 'pending',
    });
  } catch (error) {
    console.error('Error al crear pago:', error);
    throw new Error('No se pudo crear el pago');
  }
};

/**
 * Actualizar el estado de un pago
 */
exports.updateStatus = async (id, status) => {
  try {
    const [updated] = await Payment.update(
      { status },
      { where: { id } }
    );
    return updated > 0;
  } catch (error) {
    console.error('Error al actualizar estado de pago:', error);
    throw new Error('No se pudo actualizar el estado del pago');
  }
};

/**
 * Obtener los pagos de un usuario específico
 */
exports.getByUser = async (userId) => {
  try {
    return await Payment.findAll({
      where: { userId },
      order: [['createdAt', 'DESC']],
    });
  } catch (error) {
    console.error('Error al obtener pagos del usuario:', error);
    throw new Error('No se pudieron obtener los pagos del usuario');
  }
};
