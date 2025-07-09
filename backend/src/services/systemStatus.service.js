/**
 * Servicio para obtener el estado actual del sistema.
 * Incluye:
 * - Tiempo de actividad
 * - Timestamp
 * - Uso de memoria
 * - Uso de CPU
 */
exports.getSystemStatus = async () => {
  const memoryUsage = process.memoryUsage();
  const cpu = process.cpuUsage();

  return {
    uptime: parseFloat(process.uptime().toFixed(2)), // en segundos
    timestamp: new Date().toISOString(),
    memory: {
      rss: memoryUsage.rss,
      heapTotal: memoryUsage.heapTotal,
      heapUsed: memoryUsage.heapUsed,
      external: memoryUsage.external,
    },
    cpu: {
      user: cpu.user,     // microsegundos
      system: cpu.system, // microsegundos
    },
  };
};
