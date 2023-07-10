var express = require('express');
var router = express.Router();
var jwt = require('jsonwebtoken');
const { User } = require('../models')
router.get('/', function (req, res, next) {
    res.json(req.user); // return user's data
});

module.exports = router;
