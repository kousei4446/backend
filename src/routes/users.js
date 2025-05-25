const router = require('express').Router();
const auth = require('../middlewares/auth');
const ctrl = require('../controllers/usersController');

router.get('/:id', auth, ctrl.me);
router.put('/:id',auth, ctrl.updateMe);

module.exports = router;
