/**
 * Obtener estado del sistema
 * - Uptime (segundos desde que se inició el proceso)
 * - Timestamp actual
 * - Uso de memoria (heap y RSS)
 * - Uso de CPU (user/system en microsegundos)
 */
async function getSystemStatus() {
  return {
    uptime: parseFloat(process.uptime().toFixed(2)), // segundos
    timestamp: new Date().toISOString(),
    memory: {
      rss: process.memoryUsage().rss,               // memoria total reservada
      heapTotal: process.memoryUsage().heapTotal,   // memoria total del heap
      heapUsed: process.memoryUsage().heapUsed,     // memoria usada del heap
      external: process.memoryUsage().external,     // buffers externos
    },
    cpuUsage: process.cpuUsage(), // { user, system } en microsegundos
  };
}

module.exports = {
  getSystemStatus,
};
