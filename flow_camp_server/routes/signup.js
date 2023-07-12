var express = require('express');
var router = express.Router();
const { User } = require('../models');

router.post('/', async function (req, res, next) {
  try {
    console.log("----");
    const { uid, password, platform } = req.body;
    console.log(uid, password, platform);
    
    const [user, created] = await User.findOrCreate({
      where: { uid: uid, platform: platform },
      defaults: { password: password }
    });

    if (!created) {
      return res.status(400).send('User already exists with this uid and platform');
    }

    res.json(user);

  } catch (error) {
    console.error(error);
    res.status(500).send("Server Error");
  }
});

module.exports = router;
