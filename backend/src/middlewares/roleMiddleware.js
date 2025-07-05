// backend/src/middlewares/roleMiddleware.js

function authorizeRoles(...allowedRoles) {
  return (req, res, next) => {
    // Suponemos que el usuario ya está autenticado y su info está en req.user
    const user = req.user;

    if (!user) {
      return res.status(401).json({ success: false, error: 'No autenticado' });
    }

    if (!allowedRoles.includes(user.role)) {
      return res.status(403).json({ success: false, error: 'Acceso denegado: rol no autorizado' });
    }

    next();
  };
}

module.exports = authorizeRoles;
