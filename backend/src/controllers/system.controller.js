import os from 'os';
import process from 'process';
import db from '../config/db.js';

export const getSystemStatus = async (req, res) => {
  try {
    // Verificar conexión a la base de datos
    await db.connect(); // o db.authenticate() según configuración

    const status = {
      uptime: process.uptime(), // tiempo en segundos
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

    res.status(200).json({ success: true, data: status });
  } catch (error) {
    console.error('❌ Error en system status:', error);
    res.status(500).json({
      success: false,
      error: 'Fallo en la conexión a la base de datos',
      dbConnected: false,
      uptime: process.uptime(),
    });
  }
};
