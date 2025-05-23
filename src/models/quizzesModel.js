const pool = require('../config/db');

exports.randomList = async () => {
  const [rows] = await pool.query(
    `SELECT id AS questionId, quiz AS question,
            option1, option2, option3, option4, answer
     FROM quizzes WHERE deleted_at IS NULL
     ORDER BY RAND() LIMIT 10`,
  );
  return rows;
};

exports.findById = async (id) => {
  const [rows] = await pool.query(
    `SELECT id AS questionId, quiz AS question,
            option1, option2, option3, option4, level
     FROM quizzes WHERE id = ?`,
    [id],
  );
  return rows[0];
};
