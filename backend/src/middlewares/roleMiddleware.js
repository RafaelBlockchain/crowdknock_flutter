function roleMiddleware(requiredRole) {
  return (req, res, next) => {
    const user = req.user;

    if (!user) {
      return res.status(401).json({ success: false, error: 'Usuario no autenticado' });
    }

    if (user.role !== requiredRole) {
      return res.status(403).json({ success: false, error: 'Acceso denegado: rol insuficiente' });
    }

    next();
  };
}

module.exports = roleMiddleware;
