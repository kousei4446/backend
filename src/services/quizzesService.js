const quizzesModel = require('../models/quizzesModel');
const pool = require('../config/db');

exports.list = async () => quizzesModel.randomList();

exports.get = async (id) => quizzesModel.findById(id);

exports.getByLevel = async (level, levelId) =>
  quizzesModel.findByLevel(level, levelId);


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


exports.getQuizById = async (quizId) => {
  const { rows } = await pool.query(
    `SELECT id        AS "questionId",
          quiz       AS "question",
           option1,
           option2,
           option3,
           option4,
           level,
           explanation
    FROM quizzes
   WHERE id = $1`,
    [quizId],
  );
  return rows[0];
}