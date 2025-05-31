const quizzesModel = require('../models/quizzesModel');
const pool = require('../config/db');

exports.list = async () => quizzesModel.randomList();

exports.get = async (id) => quizzesModel.findById(id);

exports.getByLevel = async (level, levelId) => quizzesModel.findByLevel(level, levelId);

exports.getQuizById = async (quizId) => quizzesModel.getQuizById(quizId);

exports.getRandomQuiz = async () => quizzesModel.getRandomQuiz();

exports.answer = async ({ userId, questionLevel, isCorrect }) => {
  const inc = isCorrect ? 1 : 0;

  const clearCol = `${questionLevel}_clear_num`;
  const correctCol = `${questionLevel}_correct_num`;

  const query = `
    UPDATE trx_user
    SET ${clearCol} = ${clearCol} + $1,
        ${correctCol} = ${correctCol} + 1
    WHERE u_id = $2
  `;

  try {
    await pool.query(query, [inc, userId]);
  } catch (err) {
    console.error("❌ クイズ正誤登録失敗:", err.message);
    throw err;
  }
};
