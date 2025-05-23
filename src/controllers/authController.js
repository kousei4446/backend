const authService = require('../services/authService');

exports.login = async (req, res) => {
  try {
    const result = await authService.loginOrRegister(req.body);
    res.json(result);
  } catch (e) {
    res.status(401).json({ message: e.message });
  }
};
