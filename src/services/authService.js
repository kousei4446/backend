const userModel = require('../models/userModel');

exports.loginOrRegister = async ({ userId, userName, email }) => {
  let user = await userModel.findById(userId);
  if (!user) {
    await userModel.create({
      u_id: userId,
      email,
      user_name: userName,
    });
    user = await userModel.findById(userId);
  }

  return { userId: user.u_id }; // ✅ 自前のトークンは返さない
};
