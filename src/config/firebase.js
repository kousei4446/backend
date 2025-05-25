const admin = require('firebase-admin');

admin.initializeApp({
  credential: admin.credential.cert(process.env.GOOGLE_APPLICATION_CREDENTIALS),
});

console.log('[INFO] Firebase Admin Initialized');
module.exports = admin;
