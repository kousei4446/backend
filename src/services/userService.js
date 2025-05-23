const userModel = require('../models/userModel');

exports.getMe = async (userId) => {
  const u = await userModel.findById(userId);
  if (!u) return null;
  return {
    userId: u.u_id,
    email: u.email,
    userName: u.user_name,
    iconPath: u.icon_path,
    role: u.role,
    stats: {
      hardClearNum: u.hard_clear_num,
      normalClearNum: u.normal_clear_num,
      easyClearNum: u.easy_clear_num,
      hardCorrectNum: u.hard_correct_num,
      normalCorrectNum: u.normal_correct_num,
      easyCorrectNum: u.easy_correct_num,
    },
    createdAt: u.created_at,
    updatedAt: u.updated_at,
  };
};
exports.updateMe = async (userId, { userName, iconPath }) => {
    await userModel.updateMe(userId, { userName, iconPath });
    return { message: '更新完了' };
};