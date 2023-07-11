var express = require('express');
var router = express.Router();
const { Interest } = require('../models');

/* GET home page. */
router.get('/', async function(req, res, next) {
    const interest = await Interest.findAll();
    var interestList = [];
    interest.forEach((value, index, array)=>{
        if(value.confirmed){
            interestList.push(value.name);
        }
    })
    res.send(interestList);
});

module.exports = router;