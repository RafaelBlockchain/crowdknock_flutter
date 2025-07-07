import { Request, Response } from 'express';
import { systemStatusService } from '../services/system_status.service';

export const getSystemStatus = async (_req: Request, res: Response) => {
  try {
    const status = await systemStatusService.getSystemStatus();
    res.json(status);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener el estado del sistema' });
  }
};
