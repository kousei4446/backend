const express = require('express');
const logger  = require('./config/logger');
const routes  = require('./routes');

const app = express();
app.use(express.json());

// ルート統合
app.use(routes);

// エラーハンドラ例（簡易）
app.use((err, _req, res, _next) => {
  logger.error(err);
  res.status(500).json({ message: 'Internal Server Error' });
});

module.exports = app;
