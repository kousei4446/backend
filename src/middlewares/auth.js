const admin = require('../config/firebase');

module.exports = async (req, res, next) => {
  const header = req.headers.authorization;
  if (!header || !header.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'Unauthorized' });
  }

  const idToken = header.split(' ')[1];

  try {
    const decoded = await admin.auth().verifyIdToken(idToken);
    req.user = {
      userId: decoded.uid,
      email: decoded.email,
      name: decoded.name,
    };
    return next();
  } catch (err) {
    console.error('Firebase token error:', err.message);
    return res.status(401).json({ message: 'Invalid token' });
  }
};
