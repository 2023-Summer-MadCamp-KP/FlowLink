var express = require('express');
var router = express.Router();

/* GET home page. */
router.patch('/', async function (req, res, next) {
    try {
        console.log("info patch!!");
        const {name, gradOf, universityId, prtcpntYear, interest } = req.body;
        console.log(name, gradOf, universityId, prtcpntYear, interest);
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;