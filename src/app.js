require('dotenv').config();
const express = require('express');
const mysql   = require('mysql2/promise');
const bcrypt  = require('bcrypt');
const jwt     = require('jsonwebtoken');

const app  = express();
app.use(express.json());

// ─── DB 接続プール ───────────────────────────
const pool = mysql.createPool({
  host:     process.env.DB_HOST,
  user:     process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10
});

// ─── JWT 認証ミドルウェア ───────────────────
const auth = async (req, res, next) => {
  const header = req.headers.authorization;
  if (!header) return res.status(401).json({ message: 'Unauthorized' });

  const token = header.split(' ')[1];
  try {
    req.user = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch {
    res.status(401).json({ message: 'Invalid token' });
  }
};

// ────────────────────────────────────────────
// 🔐 POST /api/auth/login  （登録／ログイン兼用）
// ────────────────────────────────────────────
app.post('/api/auth/login', async (req, res) => {
  const { userId, userName, password, email } = req.body;
  if (!userId || !password) return res.status(400).json({ message: '必須項目が不足しています' });

  const conn = await pool.getConnection();
  try {
    const [rows] = await conn.query('SELECT * FROM trx_user WHERE u_id = ?', [userId]);

    // 既存ユーザー：パスワード検証
    if (rows.length) {
      const user = rows[0];
      const ok = await bcrypt.compare(password, user.password_hash);
      if (!ok) return res.status(401).json({ message: '認証失敗' });

      const token = jwt.sign({ userId: user.u_id }, process.env.JWT_SECRET, { expiresIn: '7d' });
      return res.json({ userId: user.u_id, token });
    }

    // 新規ユーザー登録
    const hash = await bcrypt.hash(password, 10);
    await conn.query(
      `INSERT INTO trx_user (u_id, email, user_name, password_hash)
       VALUES (?,?,?,?)`,
      [userId, email || '', userName || '', hash]
    );

    const token = jwt.sign({ userId }, process.env.JWT_SECRET, { expiresIn: '7d' });
    res.json({ userId, token });
  } finally {
    conn.release();
  }
});

// ────────────────────────────────────────────
// 👤 GET /api/users/me
// ────────────────────────────────────────────
app.get('/api/users/me', auth, async (req, res) => {
  const conn = await pool.getConnection();
  try {
    const [rows] = await conn.query('SELECT * FROM trx_user WHERE u_id = ?', [req.user.userId]);
    if (!rows.length) return res.status(404).json({ message: 'ユーザーが存在しません' });

    const u = rows[0];
    res.json({
      userId: u.u_id,
      email: u.email,
      userName: u.user_name,
      iconPath: u.icon_path,
      role: u.role,
      stats: {
        hardClearNum:   u.hard_clear_num,
        normalClearNum: u.normal_clear_num,
        easyClearNum:   u.easy_clear_num,
        hardCorrectNum: u.hard_correct_num,
        normalCorrectNum: u.normal_correct_num,
        easyCorrectNum:   u.easy_correct_num
      },
      createdAt: u.created_at,
      updatedAt: u.updated_at
    });
  } finally {
    conn.release();
  }
});

// ────────────────────────────────────────────
// 👤 PUT /api/users/me
// ────────────────────────────────────────────
app.put('/api/users/me', auth, async (req, res) => {
  const { userName, iconPath } = req.body;

  const conn = await pool.getConnection();
  try {
    await conn.query(
      'UPDATE trx_user SET user_name = COALESCE(?, user_name), icon_path = COALESCE(?, icon_path) WHERE u_id = ?',
      [userName, iconPath, req.user.userId]
    );
    res.json({ message: '更新完了' });
  } finally {
    conn.release();
  }
});

// ────────────────────────────────────────────
// ❓ GET /api/questions   （10問ランダム取得）
// ────────────────────────────────────────────
app.get('/api/questions', async (_req, res) => {
  const conn = await pool.getConnection();
  try {
    const [rows] = await conn.query(
      `SELECT id AS questionId, quiz AS question,
              option1, option2, option3, option4
       FROM questions WHERE deleted_at IS NULL
       ORDER BY RAND() LIMIT 10`
    );

    const list = rows.map(r => ({
      questionId: r.questionId,
      question:   r.question,
      choices: [
        { key: 'A', text: r.option1 },
        { key: 'B', text: r.option2 },
        { key: 'C', text: r.option3 },
        { key: 'D', text: r.option4 }
      ]
    }));
    res.json(list);
  } finally {
    conn.release();
  }
});

// ────────────────────────────────────────────
// ❓ GET /api/questions/:id   （単独取得）
// ────────────────────────────────────────────
app.get('/api/questions/:id', async (req, res) => {
  const conn = await pool.getConnection();
  try {
    const [rows] = await conn.query(
      `SELECT id AS questionId, quiz AS question,
              option1, option2, option3, option4
       FROM questions WHERE id = ?`, [req.params.id]
    );
    if (!rows.length) return res.status(404).json({ message: 'Not found' });

    const r = rows[0];
    res.json({
      questionId: r.questionId,
      question:   r.question,
      choices: [
        { key: 'A', text: r.option1 },
        { key: 'B', text: r.option2 },
        { key: 'C', text: r.option3 },
        { key: 'D', text: r.option4 }
      ]
    });
  } finally {
    conn.release();
  }
});

// ────────────────────────────────────────────
// ❓ POST /api/questions/:id/answers
//      body: { selectedAnswer: "A", isCorrect: true }
// ────────────────────────────────────────────
app.post('/api/questions/:id/answers', auth, async (req, res) => {
  const { selectedAnswer, isCorrect } = req.body;
  if (!selectedAnswer) return res.status(400).json({ message: '選択肢がありません' });

  const conn = await pool.getConnection();
  try {
    // 正答ならユーザーステータスを更新
    if (isCorrect) {
      const [[q]] = await conn.query('SELECT level FROM questions WHERE id = ?', [req.params.id]);
      if (q) {
        const clearCol   = `${q.level}_clear_num`;
        const correctCol = `${q.level}_correct_num`;
        await conn.query(
          `UPDATE trx_user
             SET ${clearCol} = ${clearCol} + 1,
                 ${correctCol} = ${correctCol} + 1
           WHERE u_id = ?`,
          [req.user.userId]
        );
      }
    }
    res.json({ message: '結果を記録しました' });
  } finally {
    conn.release();
  }
});

// ─── サーバー起動 ───────────────────────────
app.listen(process.env.PORT || 8000, () =>
  console.log(`✔ Server running → http://localhost:${process.env.PORT || 8000}`)
);

module.exports = app;
