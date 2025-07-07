export class SystemStatusService {
  async getSystemStatus() {
    return {
      database: 'operativa',
      uptime: process.uptime(),
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
