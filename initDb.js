const path = require('path');
const fs = require('fs');
const pool = require('./src/config/db');

const initSQL = fs.readFileSync(path.join(__dirname, 'init.sql'), 'utf8');
// ↑これで「initDb.js」と同じ階層にある `init.sql` を確実に読み込める

(async () => {
  try {
    await pool.query(initSQL);
    console.log("✅ DB初期化完了");
  } catch (err) {
    console.error("❌ 初期化エラー:", err.message);
  }
})();
