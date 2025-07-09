const swaggerJSDoc = require('swagger-jsdoc');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'CrowdKnock API',
      version: '1.0.0',
      description: 'Documentación de la API de CrowdKnock (backend Express + PostgreSQL)',
    },
    servers: [
      {
        url: 'http://localhost:3000/api',
        description: 'Servidor local',
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
  },
  apis: ['./routes/*.js'], // Ruta a los archivos con anotaciones Swagger
};

const swaggerSpec = swaggerJSDoc(options);
module.exports = swaggerSpec;
