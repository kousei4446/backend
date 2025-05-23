const router = require('express').Router();
const auth = require('../middlewares/auth');
const ctrl = require('../controllers/quizzesController');

router.get('/',           ctrl.list);
router.get('/:id',        ctrl.get);
router.post('/:id/answers', auth, ctrl.answer);

module.exports = router;
