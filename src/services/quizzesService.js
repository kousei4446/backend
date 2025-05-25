const quizzesModel = require('../models/quizzesModel');
const pool = require('../config/db');

exports.list = async () => quizzesModel.randomList();

exports.get = async (id) => quizzesModel.findById(id);

exports.getByLevel = async (level, levelId) =>
  quizzesModel.findByLevel(level, levelId);


exports.answer = async ({ quizId, userId, isCorrect }) => {
  if (!isCorrect) return;
  const quiz = await quizzesModel.findById(quizId);
  if (!quiz) return;

  const clearCol = `${quiz.level}_clear_num`;
  const correctCol = `${quiz.level}_correct_num`;

  await pool.query(
    `UPDATE trx_user
       SET ${clearCol} = ${clearCol} + 1,
           ${correctCol} = ${correctCol} + 1
     WHERE u_id = ?`,
    [userId],
  );
};

exports.getQuizById = async (quizId) => {
    const [rows] = await pool.query(
        `SELECT id AS questionId, quiz AS question,
                option1, option2, option3, option4, level, explanation
         FROM quizzes WHERE id = ?`,
        [quizId],
    );
    return rows[0];
}