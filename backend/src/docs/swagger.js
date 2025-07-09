const swaggerJSDoc = require('swagger-jsdoc');

const swaggerDefinition = {
  openapi: '3.0.0',
  info: {
    title: 'CrowdKnock API',
    version: '1.0.0',
    description: 'Documentación de la API de CrowdKnock (backend)',
  },
  servers: [
    {
      url: 'http://localhost:3000/api', // Cambia a tu dominio real al desplegar
      description: 'Servidor local de desarrollo',
    },
  ],
  components: {
    securitySchemes: {
      bearerAuth: {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
      },
    },
  },
  security: [{ bearerAuth: [] }],
};

const options = {
  swaggerDefinition,
  apis: ['./src/routes/*.js'], // Aquí leerá los comentarios Swagger de tus rutas
};

const swaggerSpec = swaggerJSDoc(options);

module.exports = swaggerSpec;
