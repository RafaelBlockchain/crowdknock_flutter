const express = require('express');
const router = express.Router();
const swaggerUi = require('swagger-ui-express');
const YAML = require('yamljs');
const path = require('path');

// Cargar archivo YAML de documentación
const swaggerDocument = YAML.load(path.resolve(__dirname, '../../docs/swagger.yaml'));

// Ruta: /docs → documentación interactiva
router.use(
  '/',
  swaggerUi.serve,
  swaggerUi.setup(swaggerDocument, {
    customSiteTitle: 'CrowdKnock API Docs',
    customCss: '.swagger-ui .topbar { display: none }',
  })
);

module.exports = router;
