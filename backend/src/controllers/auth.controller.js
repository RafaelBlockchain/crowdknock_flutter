const bcrypt = require('bcryptjs');
const db = require('../config/db');
const { User } = require('../models');
const { sendEmail } = require('../utils/email');
const { generateToken, verifyToken } = require('../utils/jwt');
const {
  validateEmail,
  validatePassword,
  validateRequired,
} = require('../utils/validation');

exports.register = async ({ email, password, name }) => {
  if (!validateRequired(email) || !validateEmail(email)) {
    throw { status: 400, message: 'Email inválido' };
  }

  if (!validateRequired(password) || !validatePassword(password)) {
    throw { status: 400, message: 'Contraseña inválida' };
  }

  if (!validateRequired(name)) {
    throw { status: 400, message: 'Nombre requerido' };
  }

  const existingUser = await db.oneOrNone('SELECT * FROM users WHERE email = $1', [email]);
  if (existingUser) {
    throw { status: 409, message: 'El usuario ya existe' };
  }

  const hashedPassword = await bcrypt.hash(password, 10);
  const newUser = await db.one(
    `INSERT INTO users (email, password, name, role)
     VALUES ($1, $2, $3, 'user')
     RETURNING id, email, name, role`,
    [email, hashedPassword, name]
  );

  const token = generateToken(newUser);
  return { token, user: newUser };
};

exports.login = async ({ email, password }) => {
  if (!validateRequired(email) || !validateEmail(email)) {
    throw { status: 400, message: 'Email inválido' };
  }

  if (!validateRequired(password)) {
    throw { status: 400, message: 'Contraseña requerida' };
  }

  const user = await db.oneOrNone('SELECT * FROM users WHERE email = $1', [email]);
  if (!user) throw { status: 401, message: 'Credenciales inválidas' };

  const valid = await bcrypt.compare(password, user.password);
  if (!valid) throw { status: 401, message: 'Credenciales inválidas' };

  const { password: _, ...userWithoutPassword } = user;
  const token = generateToken(userWithoutPassword);
  return { token, user: userWithoutPassword };
};

exports.verifyAuthToken = (authorizationHeader) => {
  if (!authorizationHeader) {
    throw new Error('Token no proporcionado');
  }

  const token = authorizationHeader.split(' ')[1];
  const decoded = verifyToken(token);
  return { valid: true, user: decoded };
};

exports.resetPasswordRequest = async (email) => {
  if (!email) throw { status: 400, message: 'El email es requerido' };

  const user = await User.findOne({ where: { email } });
  if (!user) throw { status: 404, message: 'Usuario no encontrado' };

  const token = generateToken({ id: user.id }, '1h');
  const resetLink = `https://frontend.crowdknock.com/reset-password?token=${token}`;

  await sendEmail({
    to: user.email,
    subject: 'Recuperación de contraseña - CrowdKnock',
    html: `
      <h2>Hola ${user.name}</h2>
      <p>Haz clic en el siguiente enlace para restablecer tu contraseña:</p>
      <a href="${resetLink}" target="_blank">${resetLink}</a>
      <p>Este enlace es válido por 1 hora.</p>
    `,
  });
};

exports.resetPassword = async (token, newPassword) => {
  if (!token || !newPassword) {
    throw new Error('Token y contraseña son requeridos');
  }

  const decoded = verifyToken(token);
  const user = await User.findByPk(decoded.id);
  if (!user) throw { status: 404, message: 'Usuario no encontrado' };

  const hashedPassword = await bcrypt.hash(newPassword, 10);
  user.password = hashedPassword;
  await user.save();
};

exports.getCurrentUser = async (userId) => {
  if (!userId) throw new Error('Token inválido o expirado');

  const user = await User.findByPk(userId);
  if (!user) throw { status: 404, message: 'Usuario no encontrado' };

  const { id, name, email, role } = user;
  return { id, name, email, role };
};
