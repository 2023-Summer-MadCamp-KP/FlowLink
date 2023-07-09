var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('2');
});

router.post('/', function(req, res, next) {
  console.log("post")
  res.render('index', { title: 'Express' });
  
});

module.exports = router;
