const router = require('express').Router();
router.use('/api/auth',    require('./auth'));
router.use('/api/users',   require('./users'));
router.use('/api/questions', require('./quizzes'));  // 一覧
router.use('/api/quizzes', require('./quizzes'));    // 個別
router.use('/api/rankings', require('./rankings'));
module.exports = router;
