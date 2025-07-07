import { Request, Response } from 'express';
import { systemStatusService } from '../services/system_status.service';

export const getSystemStatus = async (_req: Request, res: Response) => {
  try {
    const status = await systemStatusService.getSystemStatus();
    res.json(status);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener el estado del sistema' });
  }

  const systemStatus = {
    serverUptime: process.uptime(), // segundos desde que se inició el servidor
    activeUsers: 1245,              // puedes reemplazar por un query a la DB
    systemLoad: [0.12, 0.18, 0.22], // carga promedio del sistema (1m, 5m, 15m)
    memoryUsage: process.memoryUsage().rss, // en bytes
    lastDowntime: '2025-06-28T14:30:00Z',   // opcional: puedes sacarlo de logs o base de datos
  };
};
