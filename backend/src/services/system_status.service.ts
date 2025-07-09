export type ServiceStatus = 'online' | 'offline';

export interface SystemStatus {
  database: string;
  uptime: number;
  timestamp: string;
  status: 'ok' | 'error';
  services: Record<string, ServiceStatus>;
}

export class SystemStatusService {
  async getSystemStatus(): Promise<SystemStatus> {
    const uptime = parseFloat(process.uptime().toFixed(2));
    const timestamp = new Date().toISOString();

    // Puedes hacer pings reales a servicios si lo deseas
    const services: Record<string, ServiceStatus> = {
      auth: 'online',
      content: 'online',
      moderation: 'online',
      payments: 'online',
      reports: 'online',
    };

    return {
      database: 'operativa',
      uptime,
      timestamp,
      status: 'ok',
      services,
    };
  }
}

export const systemStatusService = new SystemStatusService();
