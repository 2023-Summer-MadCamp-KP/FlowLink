var express = require('express');
var router = express.Router();
const { Interest } = require('../models');

/* GET home page. */
router.get('/', async function (req, res, next) {
    try {
        const interests = await Interest.findAll({ where: { confirmed: true } });
        res.json(interests);
    } catch (err) {
        console.error(err);
        next(err);
    }
});

module.exports = router;