const authService = require('../services/authService');

exports.login = async (req, res) => {
  try {
    // console.log('Login request received:', req.body);
    const result = await authService.loginOrRegister(req.body);
    res.json(result);
  } catch (e) {
    if (e.code === 'ER_ACCESS_DENIED_ERROR') {
      return res.status(500).json({ message: 'DB connection failed' });
    }
    res.status(401).json({ message: e.message });
  }

};
