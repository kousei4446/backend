const pool = require('../config/db');

exports.getTop10ByColumn = async (column) => {
  const allowedColumns = ['hard_clear_num', 'normal_clear_num', 'easy_clear_num'];
  if (!allowedColumns.includes(column)) {
    throw new Error('Invalid column name');
  }

  const { rows } = await pool.query(`
    SELECT 
      u_id AS userId, 
      user_name AS userName, 
      ${column} AS clearNum
    FROM trx_user
    WHERE deleted_at IS NULL
    ORDER BY ${column} DESC
    LIMIT 10
  `);
  return rows;
};
