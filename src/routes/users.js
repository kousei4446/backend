const router = require('express').Router();
const auth = require('../middlewares/auth');
const ctrl = require('../controllers/usersController');

router.get('/me', auth, ctrl.me);
router.put('/me',auth, ctrl.updateMe);

module.exports = router;
