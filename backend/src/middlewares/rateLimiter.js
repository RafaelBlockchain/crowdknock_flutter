const rateLimit = require('express-rate-limit');

// 🛡️ Límite de 5 intentos por IP cada 15 minutos en /auth/login
const loginRateLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutos
  max: 3, // Máximo 3 intentos
  message: {
    success: false,
    error: 'Demasiados intentos de inicio de sesión. Intenta de nuevo más tarde.',
  },
  standardHeaders: true,
  legacyHeaders: false,
});

module.exports = {
  loginRateLimiter,
};
