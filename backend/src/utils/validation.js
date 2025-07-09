// utils/validation.js

// Valida si el email es válido
function validateEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return typeof email === 'string' && re.test(email);
}

// Valida si la contraseña cumple con requisitos mínimos
function validatePassword(password) {
  return typeof password === 'string' && password.length >= 6;
}

// Valida que un campo obligatorio no esté vacío
function validateRequired(value) {
  return value !== undefined && value !== null && value !== '';
}

// Valida que el texto esté dentro de un rango de longitud
function validateTextLength(text, min = 1, max = 255) {
  return typeof text === 'string' && text.length >= min && text.length <= max;
}

// Valida si una cadena tiene formato UUID (v4)
function validateUUID(uuid) {
  const re = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
  return typeof uuid === 'string' && re.test(uuid);
}

// Valida si un valor es un número entero
function validateInteger(value) {
  return Number.isInteger(value);
}

// Valida si un número está en un rango
function validateNumberInRange(value, min, max) {
  return typeof value === 'number' && value >= min && value <= max;
}

// Valida si un campo es una fecha ISO válida
function validateISODate(date) {
  return typeof date === 'string' && !isNaN(Date.parse(date));
}

module.exports = {
  validateEmail,
  validatePassword,
  validateRequired,
  validateTextLength,
  validateUUID,
  validateInteger,
  validateNumberInRange,
  validateISODate,
};

