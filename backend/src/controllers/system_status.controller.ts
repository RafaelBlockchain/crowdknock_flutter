import { Request, Response } from 'express';
import { systemStatusService } from '../services/system_status.service';

export const getSystemStatus = async (_req: Request, res: Response): Promise<void> => {
  try {
    const serviceData = await systemStatusService.getSystemStatus();

    // Datos adicionales del sistema desde Node.js
    const systemStatus = {
      ...serviceData,
      serverUptime: process.uptime(),
      memoryUsage: process.memoryUsage().rss, // en bytes
      systemLoad: [0.12, 0.18, 0.22],          // ejemplo estático, reemplazar con os.loadavg() si deseas
      lastDowntime: '2025-06-28T14:30:00Z',    // opcional: consulta real si tienes tracking
    };

    res.json({ success: true, data: systemStatus });
  } catch (error) {
    console.error('Error al obtener el estado del sistema:', error);
    res.status(500).json({
      success: false,
      error: 'Error al obtener el estado del sistema'
    });
  }
};
