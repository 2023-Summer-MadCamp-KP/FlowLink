var express = require('express');
var router = express.Router();
const {User} = require('../models');

/* GET home page. */
router.patch('/', async function (req, res, next) {
    var myID = req.user.id;
    console.log("myID");
    console.log("uu : "+req.user);
    try {
        console.log("info patch!!");
        const { name, gradOf, universityId, prtcpntYear, interest,bio } = req.body; // assuming 'interest' is an array of interest ids
        console.log(name, gradOf, universityId, prtcpntYear, interest);

        // find the user first
        const user = await User.findByPk(myID);

        if (user) {
            // update the user
            await user.update({
                name: name,
                gradOf: gradOf,
                universityId: universityId,
                prtcpntYear: prtcpntYear,
                infoConfirmed: true,
                bio:bio,
            });

            // update interests
            await user.setInterests(interest); // this method is provided by Sequelize for many-to-many relationships, it will replace old interests with the new ones

            res.status(200).send('User updated successfully');
        } else {
            res.status(404).send('User not found');
        }
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
});


module.exports = router;