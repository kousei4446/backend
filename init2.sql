
DROP TABLE IF EXISTS trx_user;
DROP TABLE IF EXISTS quizzes;

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

INSERT INTO trx_user (u_id, email, user_name) VALUES
  ('user001', 'alice@example.com', 'Alice'),
  ('user002', 'bob@example.com', 'Bob');

INSERT INTO quizzes (
  level, level_id, quiz,
  option1, option2, option3, option4,
  answer, explanation
) VALUES
  ('easy', 1, 'EASY Q1: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '文字列が返される', 'Noneが返る', 'dictに変換される', '実行時にSyntaxErrorが出る', 'B', '正解は B。この動作はPythonでよくあるNoneが返るケースです。'),
  ('easy', 2, 'EASY Q2: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '辞書が返される', 'Noneが返る', 'setに変換される', '実行時にTypeErrorが出る', 'B', '正解は B。この動作はPythonでよくあるNoneが返るケースです。'),
  ('easy', 3, 'EASY Q3: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '関数が返される', 'Noneが返る', 'setに変換される', '実行時にSyntaxErrorが出る', 'C', '正解は C。この動作はPythonでよくあるsetに変換されるケースです。'),
  ('easy', 4, 'EASY Q4: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '辞書が返される', 'Noneが返る', 'dictに変換される', '実行時にSyntaxErrorが出る', 'A', '正解は A。この動作はPythonでよくある辞書が返されるケースです。'),
  ('easy', 5, 'EASY Q5: Pythonに関する問題です（仮） 構文について正しいものはどれ？', '数値が返される', 'リストが返る', 'dictに変換される', '実行時にSyntaxErrorが出る', 'A', '正解は A。この動作はPythonでよくある数値が返されるケースです。'),
  ('easy', 6, 'EASY Q6: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '関数が返される', '0が返る', 'listに変換される', '実行時にKeyErrorが出る', 'B', '正解は B。この動作はPythonでよくある0が返るケースです。'),
  ('easy', 7, 'EASY Q7: Pythonに関する問題です（仮） データ型について正しいものはどれ？', '数値が返される', 'エラーが返る', 'listに変換される', '実行時にTypeErrorが出る', 'A', '正解は A。この動作はPythonでよくある数値が返されるケースです。'),
  ('easy', 8, 'EASY Q8: Pythonに関する問題です（仮） 関数について正しいものはどれ？', '数値が返される', 'リストが返る', 'dictに変換される', '実行時にSyntaxErrorが出る', 'A', '正解は A。この動作はPythonでよくある数値が返されるケースです。'),
  ('easy', 9, 'EASY Q9: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '辞書が返される', 'エラーが返る', 'dictに変換される', '実行時にKeyErrorが出る', 'C', '正解は C。この動作はPythonでよくあるdictに変換されるケースです。'),
  ('easy', 10, 'EASY Q10: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '文字列が返される', '0が返る', 'intに変換される', '実行時にTypeErrorが出る', 'A', '正解は A。この動作はPythonでよくある文字列が返されるケースです。'),
  ('normal', 1, 'NORMAL Q1: Pythonに関する問題です（仮） 関数について正しいものはどれ？', '辞書が返される', 'Noneが返る', 'setに変換される', '実行時にSyntaxErrorが出る', 'D', '正解は D。この動作はPythonでよくある実行時にSyntaxErrorが出るケースです。'),
  ('normal', 2, 'NORMAL Q2: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '数値が返される', 'Noneが返る', 'intに変換される', '実行時にSyntaxErrorが出る', 'C', '正解は C。この動作はPythonでよくあるintに変換されるケースです。'),
  ('normal', 3, 'NORMAL Q3: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '関数が返される', 'Noneが返る', 'listに変換される', '実行時にKeyErrorが出る', 'A', '正解は A。この動作はPythonでよくある関数が返されるケースです。'),
  ('normal', 4, 'NORMAL Q4: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '辞書が返される', 'Noneが返る', 'intに変換される', '実行時にTypeErrorが出る', 'C', '正解は C。この動作はPythonでよくあるintに変換されるケースです。'),
  ('normal', 5, 'NORMAL Q5: Pythonに関する問題です（仮） 関数について正しいものはどれ？', '文字列が返される', 'リストが返る', 'setに変換される', '実行時にSyntaxErrorが出る', 'C', '正解は C。この動作はPythonでよくあるsetに変換されるケースです。'),
  ('normal', 6, 'NORMAL Q6: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '文字列が返される', 'エラーが返る', 'setに変換される', '実行時にTypeErrorが出る', 'A', '正解は A。この動作はPythonでよくある文字列が返されるケースです。'),
  ('normal', 7, 'NORMAL Q7: Pythonに関する問題です（仮） 構文について正しいものはどれ？', '関数が返される', '0が返る', 'intに変換される', '実行時にSyntaxErrorが出る', 'C', '正解は C。この動作はPythonでよくあるintに変換されるケースです。'),
  ('normal', 8, 'NORMAL Q8: Pythonに関する問題です（仮） 関数について正しいものはどれ？', '文字列が返される', 'リストが返る', 'listに変換される', '実行時にTypeErrorが出る', 'C', '正解は C。この動作はPythonでよくあるlistに変換されるケースです。'),
  ('normal', 9, 'NORMAL Q9: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '文字列が返される', 'リストが返る', 'dictに変換される', '実行時にTypeErrorが出る', 'C', '正解は C。この動作はPythonでよくあるdictに変換されるケースです。'),
  ('normal', 10, 'NORMAL Q10: Pythonに関する問題です（仮） 構文について正しいものはどれ？', '文字列が返される', 'Noneが返る', 'listに変換される', '実行時にKeyErrorが出る', 'A', '正解は A。この動作はPythonでよくある文字列が返されるケースです。'),
  ('hard', 1, 'HARD Q1: Pythonに関する問題です（仮） データ型について正しいものはどれ？', '文字列が返される', '0が返る', 'setに変換される', '実行時にTypeErrorが出る', 'D', '正解は D。この動作はPythonでよくある実行時にTypeErrorが出るケースです。'),
  ('hard', 2, 'HARD Q2: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '文字列が返される', 'エラーが返る', 'dictに変換される', '実行時にSyntaxErrorが出る', 'D', '正解は D。この動作はPythonでよくある実行時にSyntaxErrorが出るケースです。'),
  ('hard', 3, 'HARD Q3: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '数値が返される', 'リストが返る', 'intに変換される', '実行時にKeyErrorが出る', 'B', '正解は B。この動作はPythonでよくあるリストが返るケースです。'),
  ('hard', 4, 'HARD Q4: Pythonに関する問題です（仮） 関数について正しいものはどれ？', '関数が返される', '0が返る', 'listに変換される', '実行時にTypeErrorが出る', 'C', '正解は C。この動作はPythonでよくあるlistに変換されるケースです。'),
  ('hard', 5, 'HARD Q5: Pythonに関する問題です（仮） 構文について正しいものはどれ？', '関数が返される', 'リストが返る', 'setに変換される', '実行時にSyntaxErrorが出る', 'B', '正解は B。この動作はPythonでよくあるリストが返るケースです。'),
  ('hard', 6, 'HARD Q6: Pythonに関する問題です（仮） データ型について正しいものはどれ？', '数値が返される', 'リストが返る', 'dictに変換される', '実行時にKeyErrorが出る', 'A', '正解は A。この動作はPythonでよくある数値が返されるケースです。'),
  ('hard', 7, 'HARD Q7: Pythonに関する問題です（仮） 構文について正しいものはどれ？', '関数が返される', 'エラーが返る', 'setに変換される', '実行時にKeyErrorが出る', 'D', '正解は D。この動作はPythonでよくある実行時にKeyErrorが出るケースです。'),
  ('hard', 8, 'HARD Q8: Pythonに関する問題です（仮） 構文について正しいものはどれ？', '関数が返される', 'リストが返る', 'intに変換される', '実行時にTypeErrorが出る', 'C', '正解は C。この動作はPythonでよくあるintに変換されるケースです。'),
  ('hard', 9, 'HARD Q9: Pythonに関する問題です（仮） 例外について正しいものはどれ？', '関数が返される', 'Noneが返る', 'setに変換される', '実行時にTypeErrorが出る', 'D', '正解は D。この動作はPythonでよくある実行時にTypeErrorが出るケースです。'),
  ('hard', 10, 'HARD Q10: Pythonに関する問題です（仮） 構文について正しいものはどれ？', '関数が返される', 'Noneが返る', 'dictに変換される', '実行時にKeyErrorが出る', 'C', '正解は C。この動作はPythonでよくあるdictに変換されるケースです。');