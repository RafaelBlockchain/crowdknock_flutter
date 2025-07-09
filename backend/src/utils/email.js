const nodemailer = require('nodemailer');
const { EMAIL_USER, EMAIL_PASS, EMAIL_HOST, EMAIL_PORT } = require('../config/env');

// Configuración del transporter
const transporter = nodemailer.createTransport({
  host: EMAIL_HOST || 'smtp.gmail.com',
  port: EMAIL_PORT || 587,
  secure: false, // true para 465, false para otros
  auth: {
    user: EMAIL_USER,
    pass: EMAIL_PASS,
  },
});

// Verificar conexión al iniciar
transporter.verify((error, success) => {
  if (error) {
    console.error('❌ Error al conectar con el servicio de correo:', error);
  } else {
    console.log('📧 Email transporter listo');
  }
});

// Función para enviar email
async function sendEmail({ to, subject, html, text }) {
  try {
    const info = await transporter.sendMail({
      from: `"CrowdKnock" <${EMAIL_USER}>`,
      to,
      subject,
      text,
      html,
    });

    console.log('📤 Email enviado:', info.messageId);
    return info;
  } catch (error) {
    console.error('❌ Error al enviar correo:', error);
    throw error;
  }
}

module.exports = {
  sendEmail,
};

