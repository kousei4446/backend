const pool = require('../config/db');
const rankingModel = require('../models/rankingModel');

exports.getTop10ByColumn = async (column) => {
  const allowedColumns = ['hard_clear_num', 'normal_clear_num', 'easy_clear_num'];
  if (!allowedColumns.includes(column)) {
    throw new Error('Invalid column name');
  }

  const { rows } = await pool.query(`
    SELECT 
      u_id AS "userId", 
      user_name AS "userName", 
      ${column} AS "clearNum"
    FROM trx_user
    WHERE deleted_at IS NULL
    ORDER BY ${column} DESC
    LIMIT 10
  `);
  return rows;
};


exports.getRankingList = async () => {
  const getTop10 = async (column) => {
    const rows = await rankingModel.getTop10ByColumn(column);
    return rows.map((row, index) => ({
      userId: row.userid,
      userName: row.username,
      rank: index + 1,
      clearNum: row.clearnum,
    }));
  };

  return {
    hard: await getTop10('hard_clear_num'),
    normal: await getTop10('normal_clear_num'),
    easy: await getTop10('easy_clear_num'),
  };
};