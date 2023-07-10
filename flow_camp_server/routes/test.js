var express = require('express');
var router = express.Router();

const { User } = require('../models');

router.get('/adddummyuser', async function (req, res, next) {
  for (let i = 0; i < 100; i++) {
    let key=i.toString();
    await User.create({
      
      uid: key,
      password: key+key,
      platform: "normal",
      infoConfirmed: true,
      name: 'user'+i,
      prtcpntYear:20232,
      gradOf:20190204,
      infoConfirmed: true,
    })
  }
  res.send();
});

router.post('/', function (req, res, next) {
  console.log("post")
  console.log(req.body.uid);
  res.render('index', { title: 'Express2' });

});

module.exports = router;
