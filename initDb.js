const fs = require('fs');
const pool = require('./src/config/db');

const initSQL = fs.readFileSync('./init2.sql', 'utf8');
const initSQL2 = fs.readFileSync('./seed_python_quizzes.sql', 'utf8');

(async () => {
  try {
    await pool.query(initSQL);
    await pool.query(initSQL2);
    console.log("✅ DB初期化完了");
  } catch (err) {
    console.error("❌ 初期化エラー:", err.message);
  }
})();
