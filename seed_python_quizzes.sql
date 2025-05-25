
USE quiz;

/* ---------- EASY ---------- */
INSERT INTO quizzes
  (level, level_id, quiz, option1, option2, option3, option4, answer, explanation)
VALUES
-- Q1 代入と比較の混同
('easy',   1,
 '次のコードの 2 行目はエラーになります。原因はどれ？\n\n```python\nx = 5\nif x = 10:\n    print(\"match\")\n```',
 '演算子の左右に空白がない',
 '比較演算子ではなく代入演算子を使っている',
 'if 文にコロンがない',
 '変数名が数字で始まっている',
 'B',
 '`=` は代入演算子であり、条件式では `==` を使う必要があります。'),

-- Q2 インデントエラー
('easy',   2,
 '次のコード実行時に発生するエラーは？\n\n```python\ndef greet():\nprint(\"Hello\")\n```',
 'NameError',
 'IndentationError',
 'TypeError',
 'SyntaxError',
 'B',
 '関数内の文は 4 文字以上インデントする必要があります。'),

-- Q3 タプルの単要素
('easy',   3,
 '`(42)` は Python では何と解釈される？',
 'タプル (要素 42)',
 '整数 42',
 'リスト [42]',
 'セット {42}',
 'B',
 '単一要素タプルにするには `(42,)` と末尾にカンマが必要です。'),

/* ---------- NORMAL ---------- */
-- Q4 ミュータブル既定引数
('normal', 1,
 '次の関数を複数回呼び出すとリストが共有されてしまいます。原因となる機能は？\n\n```python\ndef append_item(item, lst=[]):\n    lst.append(item)\n    return lst\n```',
 'クロージャ',
 'シャローコピー',
 'ミュータブルなデフォルト引数',
 'ガーベジコレクション',
 'C',
 '関数定義時に `lst` が 1 度だけ生成され再利用されるため。'),

-- Q5 文字列と join
('normal', 2,
 'リスト `["a", "b", "c"]` を「-」で結合したい。誤っているコードは？',
 '"-".join(["a", "b", "c"])',
 'str.join(["a", "b", "c"], "-")',
 '\"-\" .join([\"a\", \"b\", \"c\"])',
 '\"-\".join([s for s in [\"a\",\"b\",\"c\"]])',
 'B',
 '`str.join(iterable)` の形で呼び出し、区切り文字がレシーバになります。'),

-- Q6 可変長引数のアンパック
('normal', 3,
 'リスト `args = [1, 2, 3]` を以下の関数へ渡す正しい方法は？\n\n```python\ndef add(a, b, c):\n    return a+b+c\n```',
 'add(args)',
 'add(*args)',
 'add(**args)',
 'add(args[i] for i in range(3))',
 'B',
 '`*` で位置引数としてアンパックします。'),

/* ---------- HARD ---------- */
-- Q7 クラス変数とインスタンス変数
('hard',   1,
 '次のコードで `b.items` の出力結果は？\n\n```python\nclass Box:\n    items = []\n\n    def add(self, item):\n        self.items.append(item)\n\na = Box(); b = Box()\na.add(1); b.add(2)\nprint(b.items)\n```',
 '[2]',
 '[1, 2]',
 '[]',
 'TypeError が発生',
 'B',
 '`items` はクラス変数なので全インスタンスで共有されます。'),

-- Q8 内包表記とスコープ
('hard',   2,
 'Python 3 ではリスト内包表記内の変数は外側に漏れません。次のコードの実行結果は？\n\n```python\nnums = [1, 2, 3]\n[x for x in nums]\nprint(x)\n```',
 '1',
 '3',
 'NameError',
 'None',
 'C',
 '内包表記のスコープはローカルで、外では `x` が未定義となります。');
