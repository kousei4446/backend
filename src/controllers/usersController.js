const userService = require('../services/userService');

exports.me = async (req, res) => {
  const data = await userService.getMe(req.user.userId);
  if (!data) return res.status(404).json({ message: 'ユーザーが存在しません' });
  res.json(data);
};


exports.updateMe = async (req, res) => {
  const userId = req.user.userId;
  const { name, email } = req.body; 
  const data = await userService.updateMe(userId, { userName: name, iconPath: email });
  if (!data) return res.status(404).json({ message: 'ユーザーが存在しません' });
  res.json(data);
};
