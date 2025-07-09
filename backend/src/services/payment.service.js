const { Payment, User } = require('../models');

/**
 * Obtener todos los pagos, incluyendo datos del usuario
 */
async function getAllPayments() {
  try {
    return await Payment.findAll({ include: [User] });
  } catch (error) {
    console.error('Error al obtener pagos:', error);
    throw new Error('No se pudieron obtener los pagos');
  }
}

/**
 * Crear un nuevo pago
 * @param {Object} data
 */
async function createPayment(data) {
  try {
    if (!data.userId || !data.amount || isNaN(data.amount)) {
      throw new Error('Datos de pago inválidos');
    }

    return await Payment.create(data);
  } catch (error) {
    console.error('Error al crear pago:', error);
    throw new Error('No se pudo crear el pago');
  }
}

module.exports = {
  getAllPayments,
  createPayment,
};
