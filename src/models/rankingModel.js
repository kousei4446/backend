const pool = require('../config/db');

exports.getTop10ByColumn = async (column) => {
  const { rows } = await pool.query(
    `SELECT 
       u_id AS userId, 
       user_name AS userName, 
       ${column} AS correctNum
     FROM trx_user
     WHERE deleted_at IS NULL
     ORDER BY ${column} DESC
     LIMIT 10`
  );
  return rows;
};
