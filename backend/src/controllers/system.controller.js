import { Request, Response } from 'express';
import { getStatusReport } from '../services/system_status.service';

export const getSystemStatus = async (req: Request, res: Response) => {
  try {
    const status = await getStatusReport();
    res.status(200).json({ success: true, data: status });
  } catch (error: any) {
    console.error('❌ Error en system status:', error);
    res.status(500).json({
      success: false,
      error: 'Fallo en la conexión a la base de datos',
      dbConnected: false,
      uptime: process.uptime(),
    });
  }
};
