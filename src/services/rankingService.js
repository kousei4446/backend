const pool = require('../config/db');

exports.getRankingList = async () => {
  const getTop10 = async (column) => {
    const [rows] = await pool.query(
      `SELECT 
         u_id AS userId, 
         user_name AS userName, 
         ${column} AS correctNum
       FROM trx_user
       WHERE deleted_at IS NULL
       ORDER BY ${column} DESC
       LIMIT 10`
    );

    return rows.map((row, index) => ({
      userId: row.userId,
      userName: row.userName,
      rank: index + 1,
      correctNum: row.correctNum,
    }));
  };

  return {
    hard: await getTop10('hard_clear_num'),
    normal: await getTop10('normal_clear_num'),
    easy: await getTop10('easy_clear_num'),
  };
};
