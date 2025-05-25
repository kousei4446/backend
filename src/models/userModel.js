const pool = require('../config/db');

exports.findById = async (u_id) => {
  const [rows] = await pool.query('SELECT * FROM trx_user WHERE u_id = ?', [u_id]);
  return rows[0];
};

exports.create = async ({ u_id, email, user_name }) => {
  await pool.query(
    `INSERT INTO trx_user (u_id, email, user_name)
   VALUES (?, ?, ?)`,
    [u_id, email, user_name],
  );

};

exports.updateMe = async (userId, { userName, iconPath }) => {
  const [result] = await pool.query(
    'UPDATE trx_user SET user_name = ?, icon_path = ? WHERE u_id = ?',
    [userName, iconPath, userId],
  );
  return result;
}