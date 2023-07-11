var express = require('express');
var router = express.Router();
const { Interest } = require('../models');

/* GET home page. */
router.get('/', async function(req, res, next) {
    const interest = await Interest.findAll();
    console.log(interest[0].name);
    res.send("hi");
});

module.exports = router;