const { port } = require('./config');
const logger   = require('./config/logger');
const app      = require('./app');

if (process.env.RUN_INIT === 'true') {
  require('../initDb');  // ← パスは backend/initDb.js に合わせて
}

// Swagger セットアップを追加！
require('./docs/swagger')(app);

app.listen(port, () => logger.info(`✔ Server running → http://localhost:${port}`));
