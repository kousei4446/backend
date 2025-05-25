-- DROP TABLE IF EXISTS で上書き実行可能にする
DROP TABLE IF EXISTS trx_user;
DROP TABLE IF EXISTS quizzes;

-- ユーザー情報テーブル
CREATE TABLE IF NOT EXISTS trx_user (
  u_id TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  user_name TEXT NOT NULL,
  icon_path TEXT DEFAULT 'default.png',
  role TEXT CHECK (role IN ('user', 'admin')) DEFAULT 'user',
  hard_clear_num INTEGER DEFAULT 0,
  normal_clear_num INTEGER DEFAULT 0,
  easy_clear_num INTEGER DEFAULT 0,
  hard_correct_num INTEGER DEFAULT 0,
  normal_correct_num INTEGER DEFAULT 0,
  easy_correct_num INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- クイズ問題テーブル
CREATE TABLE IF NOT EXISTS quizzes (
  id SERIAL PRIMARY KEY,
  level TEXT CHECK (level IN ('hard', 'normal', 'easy')) NOT NULL,
  level_id INTEGER NOT NULL,
  quiz TEXT NOT NULL,
  option1 TEXT,
  option2 TEXT,
  option3 TEXT,
  option4 TEXT,
  answer TEXT,
  explanation TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- ユーザーデータ挿入
INSERT INTO trx_user (u_id, email, user_name)
VALUES
  ('user001', 'alice@example.com', 'Alice'),
  ('user002', 'bob@example.com', 'Bob');
