const express = require('express');
const router = express.Router();
const auth = require('../middlewares/auth');
const ctrl = require('../controllers/rankingsController');

router.get('/', auth, ctrl.getRankingList);

module.exports = router;
