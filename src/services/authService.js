const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { jwtSecret } = require('../config');
const userModel = require('../models/userModel');

exports.loginOrRegister = async ({ userId, userName, password, email }) => {
  let user = await userModel.findById(userId);

  // 登録
  if (!user) {
    const hash = await bcrypt.hash(password, 10);
    await userModel.create({
      u_id: userId,
      email,
      user_name: userName,
      password_hash: hash,
    });
    user = await userModel.findById(userId);
  }

  // 認証
  const ok = await bcrypt.compare(password, user.password_hash);
  if (!ok) throw new Error('認証失敗');

  const token = jwt.sign({ userId: user.u_id }, jwtSecret, { expiresIn: '7d' });
  return { userId: user.u_id, token };
};
