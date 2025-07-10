// src/controllers/system_status.controller.js

const { getSystemStatus, updateSystemStatus } = require('../services/system_status.service');

const fetchSystemStatus = async (req, res) => {
  try {
    const status = await getSystemStatus();
    res.status(200).json(status);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch system status' });
  }
};

const modifySystemStatus = async (req, res) => {
  try {
    const updatedStatus = await updateSystemStatus(req.body);
    res.status(200).json(updatedStatus);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update system status' });
  }
};

module.exports = {
  fetchSystemStatus,
  modifySystemStatus,
};
