const pool = require('../config/db');

exports.findById = async (u_id) => {
  const { rows } = await pool.query(
    'SELECT * FROM trx_user WHERE u_id = $1',
    [u_id]
  );
  return rows[0];
};

exports.create = async ({ u_id, email, user_name }) => {
  await pool.query(
    `INSERT INTO trx_user (u_id, email, user_name)
     VALUES ($1, $2, $3)`,
    [u_id, email, user_name]
  );
};

exports.updateMe = async (userId, { userName, iconPath }) => {
  const { rowCount } = await pool.query(
    'UPDATE trx_user SET user_name = $1, icon_path = $2 WHERE u_id = $3',
    [userName, iconPath, userId]
  );
  return rowCount; // または成功判定に使う
};
