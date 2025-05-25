const userService = require('../services/userService');

exports.me = async (req, res) => {
  const userId = req.params.id;
  const data = await userService.getMe(userId);
  if (!data) return res.status(404).json({ message: 'ユーザーが存在しません' });
  res.json(data);
};


exports.updateMe = async (req, res) => {
  const userId = req.params.id;
  const { userName,  iconPath } = req.body;
  const data = await userService.updateMe(userId, { userName: userName, iconPath: iconPath });
  if (!data) return res.status(404).json({ message: 'ユーザーが存在しません' });
  res.json(data);
};
