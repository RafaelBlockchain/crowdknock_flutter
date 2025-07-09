// src/middlewares/roleMiddleware.js
module.exports = function roleMiddleware(allowedRoles = []) {
  return function (req, res, next) {
    if (!req.user || !allowedRoles.includes(req.user.role)) {
      return res.status(403).json({ message: 'Acceso denegado: rol no autorizado' });
    }
    next();
  };
};

function roleMiddleware(allowedRoles = []) {
  return (req, res, next) => {
    const user = req.user;

    if (!user) {
      return res.status(401).json({ success: false, error: 'Usuario no autenticado' });
    }

    if (!allowedRoles.includes(user.role)) {
      return res.status(403).json({
        success: false,
        error: `Acceso denegado: se requiere uno de los roles [${allowedRoles.join(', ')}]`,
      });
    }

    next();
  };
}

module.exports = roleMiddleware;
