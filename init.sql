-- ユーザー作成（DB作成は docker-compose.yml の POSTGRES_DB に任せる）
CREATE USER quizuser WITH PASSWORD 'quizpass';
GRANT ALL PRIVILEGES ON DATABASE quiz TO quizuser;

-- テーブル削除・作成・初期データ投入はそのままでOK
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
  ('easy', 1, 'Pythonでリストの要素数を取得する方法は？', 'len()', 'count()', 'size()', 'length()', 'A', '`len()` 関数でリストの要素数を取得します。'),
  ('easy', 2, 'Pythonで辞書のキー一覧を取得するには？', 'dict.keys()', 'dict.values()', 'dict.items()', 'dict.all()', 'A', '`keys()` メソッドでキー一覧が取得できます。'),
  ('easy', 3, 'Pythonのリストに要素を追加するには？', 'append()', 'add()', 'push()', 'insert()', 'A', '`append()` メソッドで末尾に追加します。'),
  ('easy', 4, 'Pythonで整数を文字列に変換する関数は？', 'str()', 'int()', 'char()', 'convert()', 'A', '`str()` で整数を文字列に変換できます。'),
  ('easy', 5, 'Pythonで変数の型を調べる関数は？', 'type()', 'kind()', 'format()', 'id()', 'A', '`type()` で型がわかります。'),
  ('easy', 6, 'Pythonで文字列を整数に変換する関数は？', 'int()', 'str()', 'float()', 'chr()', 'A', '`int()` で整数に変換します。'),
  ('easy', 7, 'Pythonでインデントに使うべきは？', 'タブ', '半角スペース', '全角スペース', '両方可', 'B', 'PEP8では半角スペースを推奨しています。'),
  ('easy', 8, 'Pythonでコメントを書く方法は？', '//', '#', '--', '/* */', 'B', '`#` を使ってコメントを記述します。'),
  ('easy', 9, 'Pythonで論理ANDを表すキーワードは？', 'and', '&&', '&', 'AND', 'A', '`and` が正しい論理ANDです。'),
  ('easy', 10, 'PythonでNoneを判定するには？', 'value = None', 'value == None', 'is None', 'isNull(value)', 'C', '`is None` が正しい書き方です。'),
  ('normal', 1, 'Pythonでリストを逆順に並び替えるメソッドは？', 'reverse()', 'reversed()', 'sort(reverse=True)', '反転()', 'A', '`reverse()` でその場で逆順に並び替えます。'),
  ('normal', 2, 'Pythonで関数の引数にデフォルト値を指定する正しい方法は？', 'def func(x=1):', 'def func(x):=1', 'func def(x=1):', 'def(x=1) func:', 'A', '関数定義で `def func(x=1):` の形式で指定します。'),
  ('normal', 3, 'Pythonでリスト内包表記の書き方は？', '[x for x in list]', 'for x in list -> x', '{x in list}', 'list(x)', 'A', '[x for x in list] の形式です。'),
  ('normal', 4, 'Pythonの例外処理に使うキーワードは？', 'try-except', 'try-catch', 'throw-catch', 'try-handle', 'A', 'Pythonでは `try-except` を使用します。'),
  ('normal', 5, 'Pythonの標準入力を取得する関数は？', 'input()', 'scan()', 'read()', 'gets()', 'A', '`input()` で標準入力を取得します。'),
  ('normal', 6, 'Pythonでクラスを定義するキーワードは？', 'class', 'define', 'struct', 'type', 'A', '`class` を使ってクラスを定義します。'),
  ('normal', 7, 'Pythonでファイルを読み込むには？', 'open(''file.txt'')', 'read(''file.txt'')', 'get(''file.txt'')', 'load(''file.txt'')', 'A', 'open() でファイルを開きます。'),
  ('normal', 8, 'Pythonで複数行の文字列を扱う方法は？', '''''''text''''''', '`text`', '//text//', 'text()', 'A', ''''''' または """ を使って複数行文字列を定義できます。'),
  ('normal', 9, 'Pythonで辞書の全要素をループする方法は？', 'for k, v in dict.items()', 'for each in dict', 'loop dict', 'dict.loop()', 'A', 'items() を使ってキーと値を取得できます。'),
  ('normal', 10, 'PythonでNoneとの比較で推奨される方法は？', 'is None', '== None', '= None', 'equals None', 'A', '`is None` が推奨される方法です。'),
  ('hard', 1, 'Pythonでデコレータとは何か？', '関数をラップする関数', '関数をコピーする構文', '関数を削除する命令', '関数を変数化する方法', 'A', 'デコレータは関数をラップして機能を追加します。'),
  ('hard', 2, 'Pythonのジェネレータ式の利点は？', 'メモリ効率が良い', '計算が速い', 'コードが短い', '複数スレッドで動く', 'A', 'ジェネレータは遅延評価でメモリ効率が良いです。'),
  ('hard', 3, 'Pythonでwith文の利点は？', '自動的にcloseされる', '同期処理になる', 'デバッグしやすい', 'メモリが倍速になる', 'A', '`with` によってリソースの開放が保証されます。'),
  ('hard', 4, 'Pythonでラムダ関数の正しい定義方法は？', 'lambda x: x + 1', 'x -> x + 1', 'function(x) = x + 1', 'def x(x): return x+1', 'A', 'lambda x: x + 1 の形式で定義します。'),
  ('hard', 5, 'Pythonでスレッドを扱うには？', 'threading モジュール', 'multiprocessing モジュール', 'thread モジュール', 'parallel モジュール', 'A', 'スレッドは threading モジュールで扱います。'),
  ('hard', 6, 'Pythonで型ヒントを使う理由は？', 'コードの可読性向上', '実行速度向上', 'メモリ使用減', '例外処理強化', 'A', '型ヒントでIDEや補完が使いやすくなります。'),
  ('hard', 7, 'Pythonで例外を再送出する方法は？', 'raise', 'throw', 'error', 'except', 'A', '`raise` を使って再送出します。'),
  ('hard', 8, 'Pythonで再帰関数が必要な場合は？', '自己参照処理', '高速化', '型チェック', 'ファイル操作', 'A', '再帰関数は分割・構造的な処理に適します。'),
  ('hard', 9, 'Pythonでグローバル変数を関数内で使うには？', 'global宣言する', 'constで囲う', 'defで囲う', 'varで囲う', 'A', '`global` 宣言で明示的に使えます。'),
  ('hard', 10, 'Pythonでソートをカスタマイズするには？', 'key引数を使う', 'sortmodeを使う', 'setmodeを使う', 'compareを使う', 'A', 'key=関数 でカスタムソートができます。');


GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO quizuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO quizuser;
