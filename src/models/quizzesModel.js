const pool = require('../config/db');

exports.randomList = async () => {
  const { rows } = await pool.query(
    `SELECT id AS questionId, quiz AS question,
            option1, option2, option3, option4, answer
     FROM quizzes
     WHERE deleted_at IS NULL
     ORDER BY RANDOM() LIMIT 10`
  );
  return rows;
};

exports.findById = async (id) => {
  const { rows } = await pool.query(
    `SELECT id AS questionId, quiz AS question,
            option1, option2, option3, option4,
            level, explanation, answer
     FROM quizzes
     WHERE id = $1 AND deleted_at IS NULL`,
    [id]
  );
  return rows[0];
};

exports.findByLevel = async (level, levelId) => {
  const { rows } = await pool.query(
    `SELECT id AS questionId,
            quiz AS question,
            option1, option2, option3, option4,
            answer, explanation, level
     FROM quizzes
     WHERE level = $1 AND level_id = $2 AND deleted_at IS NULL`,
    [level, levelId]
  );
  return rows[0];
};

exports.getRandomQuiz = async () => {
  const { rows } = await pool.query(
    `SELECT id AS questionId,
            quiz AS question,
            option1, option2, option3, option4,
            level, explanation
     FROM quizzes
     WHERE deleted_at IS NULL
     ORDER BY RANDOM()
     LIMIT 10`
  );
  return rows;
};

exports.getQuizById = async (quizId) => {
  const { rows } = await pool.query(
    `SELECT id AS questionId,
            quiz AS question,
            option1, option2, option3, option4,
            level, explanation
     FROM quizzes
     WHERE id = $1 AND deleted_at IS NULL`,
    [quizId]
  );
  return rows[0];
};
