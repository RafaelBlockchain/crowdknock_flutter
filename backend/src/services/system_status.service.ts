export interface SystemStatus {
  database: string;
  uptime: number;
  timestamp: string;
  status: 'ok' | 'error';
  services: Record<string, 'online' | 'offline'>;
}

export class SystemStatusService {
  async getSystemStatus(): Promise<SystemStatus> {
    return {
      database: 'operativa',
      uptime: parseFloat(process.uptime().toFixed(2)),
      timestamp: new Date().toISOString(),
      status: 'ok',
      services: {
        auth: 'online',
        content: 'online',
        moderation: 'online',
        payments: 'online',
        reports: 'online',
      },
    };
  }
}

export const systemStatusService = new SystemStatusService();
