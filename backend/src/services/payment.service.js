const { Payment, User } = require('../models');

async function getAllPayments() {
  return await Payment.findAll({ include: [User] });
}

async function createPayment(data) {
  return await Payment.create(data);
}

module.exports = { getAllPayments, createPayment };
