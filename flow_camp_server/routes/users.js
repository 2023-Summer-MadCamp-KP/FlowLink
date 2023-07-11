var express = require('express');
var router = express.Router();
const { User } = require('../models');
const {University} = require('../models');

router.get('/', async function (req, res, next) {
  try {
    const users = await User.findAll({
      where: { infoConfirmed: true }, include: [{
        model: University,
        required: true,
        as: 'university' // use the same alias as specified when defining the association
      },],
    });
    res.json(users);
  } catch (err) {
    console.error(err);
    next(err);
  }
});

module.exports = router;
