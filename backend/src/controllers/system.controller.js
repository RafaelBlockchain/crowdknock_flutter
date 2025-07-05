import os from 'os';
import process from 'process';
import db from '../config/db.js';

export const getSystemStatus = async (req, res) => {
  try {
    // Verificar conexión con la base de datos
    await db.authenticate();

    const status = {
      uptime: process.uptime(), // segundos desde que inició el servidor
      dbConnected: true,
      version: '1.0.0',
      memoryUsage: process.memoryUsage(),
      platform: os.platform(),
      services: {
        emails: 'ok',
        push: 'ok',
        payments: 'ok'
      }
    };

    res.status(200).json(status);
  } catch (error) {
    res.status(500).json({
      uptime: process.uptime(),
      dbConnected: false,
      error: 'Failed to connect to database',
    });
  }
};
