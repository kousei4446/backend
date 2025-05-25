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

exports.findByLevel = async (level, levelId) => {
  const [rows] = await pool.query(
    `SELECT id   AS questionId,
            quiz AS question,
            option1, option2, option3, option4,
            answer, explanation, level
       FROM quizzes
      WHERE level = ? AND level_id = ? AND deleted_at IS NULL`,
    [level, levelId],
  );
  return rows[0];
};