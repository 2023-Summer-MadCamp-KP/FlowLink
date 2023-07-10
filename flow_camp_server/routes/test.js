var express = require('express');
var router = express.Router();

const { User } = require('../models');

router.get('/adduser', function (req, res, next) {
  User.create({
    name: "test3",
    token: "test2",
  })
  res.send('3');
});

router.post('/', function (req, res, next) {
  console.log("post")
  console.log(req.body.uid);
  res.render('index', { title: 'Express2' });

});

module.exports = router;
