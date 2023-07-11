var express = require('express');
var router = express.Router();
const { University } = require('../models');

router.get('/', async function(req, res, next) {
    try {
        const universities = await University.findAll();
        res.json(universities);
    } catch (err) {
        next(err);
    }
});

module.exports = router;
