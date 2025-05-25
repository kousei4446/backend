const quizzesModel = require('../models/quizzesModel');
const pool = require('../config/db');

exports.list = async () => quizzesModel.randomList();

exports.get = async (id) => quizzesModel.findById(id);

exports.getByLevel = async (level, levelId) =>
  quizzesModel.findByLevel(level, levelId);


exports.answer = async ({ userId,questionLevel,isCorrect }) => {
  let inc = 1
  if (!isCorrect) {
    inc = 0
  }

  const clearCol = `${questionLevel}_clear_num`;
  const correctCol = `${questionLevel}_correct_num`;

  await pool.query(
    `UPDATE trx_user
       SET ${clearCol} = ${clearCol} + ${inc},
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