var express = require('express');
var router = express.Router();
const { User } = require('../models');

router.post('/', async function (req, res, next) {

  try {
    const { uid, password, platform } = req.body;

    // Check if user already exists
    const existingUser = await User.findOne({ where: { uid: uid, platform: platform } });

    if (existingUser) {
      return res.status(400).send('User already exists with this uid and platform');
    }

    // If user doesn't exist, create new user
    const newUser = await User.create({ uid, password, platform });

    res.json(newUser);

  } catch (error) {
    console.error(error);
    res.status(500).send("Server Error");
  }
});

module.exports = router;
