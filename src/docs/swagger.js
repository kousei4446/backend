const fs = require('fs');
const path = require('path');
const yaml = require('yaml');
const swaggerUi = require('swagger-ui-express');

module.exports = (app) => {
  try {
    const file = fs.readFileSync(path.join(__dirname, 'openapi.yml'), 'utf8');
    const spec = yaml.parse(file);

    app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(spec));
    console.log('[INFO] Swagger UI available at /api-docs');
  } catch (err) {
    console.error('[ERROR] Failed to load Swagger spec:', err.message);
  }
};
