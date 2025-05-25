const quizzesService = require('../services/quizzesService');

exports.list = async (_req, res) => {
  const list = await quizzesService.list();
  res.json(list);
};

// controller
exports.get = async (req, res) => {
  const { level, levelId } = req.params;
  const quiz = await quizzesService.getByLevel(level, levelId);
  if (!quiz) return res.status(404).json({ message: 'Not found' });
  res.json(quiz);
};

exports.answer = async (req, res) => {
  const { selectedAnswer, isCorrect } = req.body;
  const quizId = req.params.id;

  if (!selectedAnswer) {
    return res.status(400).json({ message: '選択肢がありません' });
  }

  // 回答を記録
  await quizzesService.answer({
    quizId,
    userId: req.user.userId,
    isCorrect,
  });

  // 解説を取得
  const quiz = await quizzesService.getQuizById(quizId); // quiz.explanation を取得できる前提

  res.json({
    explanation: quiz?.explanation || '解説が見つかりませんでした',
  });
};

