const fs = require('fs');
const pool = require('./src/config/db');

const initSQL = fs.readFileSync('./init2.sql', 'utf8');

(async () => {
  try {
    await pool.query(initSQL);
    console.log("✅ DB初期化完了");
  } catch (err) {
    console.error("❌ 初期化エラー:", err.message);
  }
})();

