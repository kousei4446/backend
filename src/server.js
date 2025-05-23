const { port } = require('./config');
const logger   = require('./config/logger');
const app      = require('./app');

// Swagger セットアップを追加！
require('./docs/swagger')(app);

app.listen(port, () => logger.info(`✔ Server running → http://localhost:${port}`));
