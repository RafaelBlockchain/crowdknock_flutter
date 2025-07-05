async function getSystemStatus() {
  return {
    uptime: process.uptime(),
    timestamp: new Date(),
    memory: process.memoryUsage(),
    cpuUsage: process.cpuUsage(),
  };
}

module.exports = { getSystemStatus };
