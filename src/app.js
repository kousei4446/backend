const express = require('express');
const cors    = require('cors'); // ← 追加
const logger  = require('./config/logger');
const routes  = require('./routes');

const app = express();

// ✅ CORSミドルウェア（必ず最初の方に）
app.use(cors({
  origin: '*', // ← 本番は 'https://your-site.com' などに制限
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(express.json());

// ルート統合
app.use(routes);

// エラーハンドラ
app.use((err, _req, res, _next) => {
  logger.error(err);
  res.status(500).json({ message: 'Internal Server Error' });
});

module.exports = app;
