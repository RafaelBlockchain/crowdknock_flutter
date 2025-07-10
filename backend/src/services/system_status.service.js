// src/services/system_status.service.js

const { SystemStatus } = require('../models/systemStatus.model');

const getSystemStatus = async () => {
  return await SystemStatus.findOne();
};

const updateSystemStatus = async (data) => {
  const status = await SystemStatus.findOne();
  if (!status) throw new Error('System status not found');
  return await status.update(data);
};

module.exports = {
  getSystemStatus,
  updateSystemStatus,
};
