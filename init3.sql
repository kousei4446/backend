/* ---------- EASY ---------- */
INSERT INTO
  quizzes (
    level,
    level_id,
    quiz,
    option1,
    option2,
    option3,
    option4,
    answer,
    explanation
  )
VALUES
  -- Q1 代入と比較の混同
  (
    'easy',
    1,
    '次のコードの 2 行目はエラーになります。原因はどれ？\n\n```python\nx = 5\nif x = 10:\n    print(\"match\")\n`  ``',
    '演算子の左右に空白がない',
    '比較演算子ではなく代入演算子を使っている',
    'if 文にコロンがない',
    '変数名が数字で始まっている',
    'B',
    '`=` は代入演算子であり、条件式では `==` を使う必要があります。'
  ),
  -- Q2 インデントエラー
  (
    'easy',
    2,
    '次のコード実行時に発生するエラーは？\n\n```python\ndef greet():\nprint(\"Hello\")\n```',
    'NameError',
    'IndentationError',
    'TypeError',
    'SyntaxError',
    'B',
    '関数内の文は 4 文字以上インデントする必要があります。'
  ),
  -- Q3 タプルの単要素
  (
    'easy',
    3,
    '`(42)` は Python では何と解釈される？',
    'タプル (要素 42)',
    '整数 42',
    'リスト [42]',
    'セット {42}',
    'B',
    '単一要素タプルにするには `(42,)` と末尾にカンマが必要です。'
  ),
  -- Q4 range の上限
  (
    'easy',
    4,
    '次のコードの出力は？\n\n```python\nfor i in range(3):\n    print(i)\n```',
    '0 1 2',
    '1 2 3',
    '0 1 2 3',
    'エラー',
    'A',
    '`range(3)` は 0,1,2 の 3 つを生成します。'
  ),
  -- Q5 f 文字列の波括弧忘れ
  (
    'easy',
    5,
    'f 文字列で変数を展開する正しい方法は？\n\n`name = "Bob"`',
    'f"My name is {name}"',
    'f"My name is name"',
    '"My name is {name}"',
    'f"My name is ${name}"',
    'A',
    '`{}` 内に変数を書く必要があります。'
  ),
  -- Q6 リストコピーの混乱
  (
    'easy',
    6,
    '次のうち **リストのシャローコピー** を作る正しい方法は？\n\n`lst = [1,2,3]`',
    'lst2 = lst',
    'lst2 = lst.copy()',
    'lst2 = copy(lst)',
    'lst2 = deepcopy(lst)',
    'B',
    '`.copy()` か `lst[:]` がシャローコピー。`=` は参照共有。'
  ),
  -- Q7 while 無限ループ
  (
    'easy',
    7,
    '無限ループを避けるにはどこを修正？\n\n```python\nx = 0\nwhile x < 5:\n    print(x)\n```',
    'ループ内で x をインクリメントする',
    'while を for に変える',
    'print を削除',
    'x を 5 に初期化',
    'A',
    'カウンタを更新しないと条件が永遠に真になります。'
  ),
  -- Q8 split の戻り値型
  (
    'easy',
    8,
    '`"a,b,c".split(",")` の戻り値は？',
    '文字列',
    'リスト',
    'タプル',
    '辞書',
    'B',
    '`split` はリストを返します。'
  ),
  -- Q9 dict キーアクセス
  (
    'easy',
    9,
    '`d = {"x":1}` で存在しないキー `d["y"]` にアクセスすると？',
    '0 が返る',
    'None が返る',
    'KeyError',
    '空文字が返る',
    'C',
    '存在しないキーは `KeyError`。安全に取るなら `d.get("y")`。'
  ),
  -- Q10 コメントアウトの書式
  (
    'easy',
    10,
    'Python の複数行コメントに最も適しているのは？',
    '""" コメント """',
    '# コメント',
    '/* コメント */',
    '// コメント',
    'A',
    '慣例的に docstring 形式を使うか行頭 # を複数行書きます。'
  ),
  /* ---------- NORMAL ---------- */
  -- Q4 ミュータブル既定引数
  (
    'normal',
    1,
    '次の関数を複数回呼び出すとリストが共有されてしまいます。原因となる機能は？\n\n```python\ndef append_item(item, lst=[]):\n    lst.append(item)\n    return lst\n```',
    'クロージャ',
    'シャローコピー',
    'ミュータブルなデフォルト引数',
    'ガーベジコレクション',
    'C',
    '関数定義時に `lst` が 1 度だけ生成され再利用されるため。'
  ),
  -- Q5 文字列と join
  (
    'normal',
    2,
    'リスト `["a", "b", "c"]` を「-」で結合したい。誤っているコードは？',
    '"-".join(["a", "b", "c"])',
    'str.join(["a", "b", "c"], "-")',
    '\"-\" .join([\"a\", \"b\", \"c\"])',
    '\"-\".join([s for s in [\"a\",\"b\",\"c\"]])',
    'B',
    '`str.join(iterable)` の形で呼び出し、区切り文字がレシーバになります。'
  ),
  -- Q6 可変長引数のアンパック
  (
    'normal',
    3,
    'リスト `args = [1, 2, 3]` を以下の関数へ渡す正しい方法は？\n\n```python\ndef add(a, b, c):\n    return a+b+c\n```',
    'add(args)',
    'add(*args)',
    'add(**args)',
    'add(args[i] for i in range(3))',
    'B',
    '`*` で位置引数としてアンパックします。'
  ),
  -- Q4 リストと set の速度
  (
    'normal',
    4,
    'メンバーシップ判定が高速なのはどちら？ 100 万要素の\n`list_numbers` と `set_numbers` 比較で `x in numbers`',
    'リスト',
    'セット',
    'どちらも同じ',
    '要素数による',
    'B',
    'set はハッシュで O(1)。list は線形探索で O(n)。'
  ),
  -- Q5 enumerate の開始値
  (
    'normal',
    5,
    '次のコードの出力は？\n\n```python\nfor i, v in enumerate([\"a\",\"b\"], start=1):\n    print(i, v)\n```',
    '0 a / 1 b',
    '1 a / 2 b',
    'a 1 / b 2',
    'エラー',
    'B',
    '`start=1` でカウンタ開始値を指定できます。'
  ),
  -- Q6 with 文とファイル
  (
    'normal',
    6,
    '`with open(\"file.txt\") as f:` を使う主な利点は？',
    '読み取りが速くなる',
    '自動でファイルを閉じる',
    'スレッドセーフになる',
    'ファイルが存在しない場合自動生成',
    'B',
    '`with` ブロックを抜けると `close()` が自動実行。'
  ),
  /* ---------- HARD ---------- */
  -- Q7 クラス変数とインスタンス変数
  (
    'hard',
    1,
    '次のコードで `b.items` の出力結果は？\n\n```python\nclass Box:\n    items = []\n\n    def add(self, item):\n        self.items.append(item)\n\na = Box(); b = Box()\na.add(1); b.add(2)\nprint(b.items)\n```',
    '[2]',
    '[1, 2]',
    '[]',
    'TypeError が発生',
    'B',
    '`items` はクラス変数なので全インスタンスで共有されます。'
  ),
  -- Q8 内包表記とスコープ
  (
    'hard',
    2,
    'Python 3 ではリスト内包表記内の変数は外側に漏れません。次のコードの実行結果は？\n\n```python\nnums = [1, 2, 3]\n[x for x in nums]\nprint(x)\n```',
    '1',
    '3',
    'NameError',
    'None',
    'C',
    '内包表記のスコープはローカルで、外では `x` が未定義となります。'
  );

-- Q3 ジェネレータ式と遅延評価
(
  'hard',
  3,
  'メモリ効率が良いのはどれ？\n\n`sum([i*i for i in range(10**6)])`\n`sum(i*i for i in range(10**6))`',
  'リスト内包表記',
  'ジェネレータ式',
  'どちらも同じ',
  '計算できない',
  'B',
  'ジェネレータは1要素ずつ生成しリストを保持しない。'
),
-- Q4 デコレータの副作用
(
  'hard',
  4,
  '次のコードで `@memo` デコレータが **キャッシュを共有** するのはなぜ？\n\n```python\ncache = {}\n\ndef memo(fn):\n    def wrapper(x):\n        if x in cache:\n            return cache[x]\n        cache[x] = fn(x)\n        return cache[x]\n    return wrapper\n\n@memo\ndef fib(n):\n    ...\n```',
  '高階関数だから',
  'クロージャ変数 `cache` が外側で 1 つだけだから',
  '`global` を使っているから',
  'デコレータはクラスとして実装すべきだから',
  'B',
  'ラップ関数が同一の `cache` 辞書を閉じ込め、全呼び出しで共有。'
),
-- Q5 contextlib.contextmanager
(
  'hard',
  5,
  '`contextlib.contextmanager` で生成したコンテキストマネージャに必要なキーワードは？\n\n```python\nfrom contextlib import contextmanager\n\n@contextmanager\ndef temp_chdir(path):\n    ...\n```',
  '`yield`',
  '`return`',
  '`await`',
  '`break`',
  'A',
  '関数内で `yield` して前後処理を書くことで with 文に対応します。'
);