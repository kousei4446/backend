const quizzesService = require('../services/quizzesService');

exports.list = async (_req, res) => {
  const list = await quizzesService.list();
  res.json(list);
};

// controller
exports.get = async (req, res) => {
  const { level, levelId } = req.params;
  const quiz = await quizzesService.getByLevel(level, levelId);
  console.log(quiz);
  if (!quiz) return res.status(404).json({ message: 'Not found' });
  res.json(quiz);
};

exports.answer = async (req, res) => {
  try {
    const { userId, questionLevel, isCorrect } = req.body;

    if (!userId || !questionLevel || typeof isCorrect !== "boolean") {
      return res.status(400).json({ message: 'Invalid request' });
    }

    // 回答を記録
    await quizzesService.answer({
      userId,
      questionLevel,
      isCorrect,
    });

    // 解説を取得（必要ならここで取得処理を追加）

    res.json({
      message: "正誤登録完了"
    });
  } catch (err) {
    console.error('Error in answer controller:', err);
    res.status(500).json({ message: 'サーバーエラーが発生しました' });
  }
};

exports.random = async (req, res) => {
  try {
    const quiz = await quizzesService.getRandomQuiz();
    if (!quiz) return res.status(404).json({ message: 'No quiz found' });
    res.json(quiz);
  } catch (err) {
    console.error('Error in random controller:', err);
    res.status(500).json({ message: 'サーバーエラーが発生しました' });
  }
}