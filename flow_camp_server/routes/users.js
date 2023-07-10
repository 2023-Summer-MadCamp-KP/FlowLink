var express = require('express');
var router = express.Router();
const { User } = require('../models');

router.get('/', async function(req, res, next) {
  try {
    const users = await User.findAll({where: { infoConfirmed: true } });
    res.json(users);
  } catch (err) {
    console.error(err);
    next(err);
  }
});

module.exports = router;
