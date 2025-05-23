// src/docs/swagger.js
const fs = require('fs');
const path = require('path');
const yaml = require('yaml');
const swaggerUi = require('swagger-ui-express');

module.exports = (app) => {
  const file = fs.readFileSync(path.join(__dirname, 'openapi.yml'), 'utf8');
  const spec = yaml.parse(file);

  // ここで /api-docs に登録しているか？
  app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(spec));
};
