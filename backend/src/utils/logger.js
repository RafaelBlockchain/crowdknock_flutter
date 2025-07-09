const { createLogger, format, transports } = require('winston');
const { combine, timestamp, printf, colorize } = format;

// 🔧 Formato personalizado
const logFormat = printf(({ level, message, timestamp }) => {
  return `[${timestamp}] ${level}: ${message}`;
});

const logger = createLogger({
  level: 'info', // Nivel mínimo de logs
  format: combine(
    timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
    logFormat
  ),
  transports: [
    // 🖨️ Consola (color)
    new transports.Console({
      format: combine(colorize(), logFormat)
    }),

    // 🗂️ Archivos por nivel
    new transports.File({ filename: 'logs/error.log', level: 'error' }),
    new transports.File({ filename: 'logs/combined.log' })
  ],
  exitOnError: false,
});

module.exports = logger;
