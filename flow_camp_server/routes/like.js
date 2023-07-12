var express = require('express');
var router = express.Router();
const { Like, User,University,Interest } = require('../models')


router.get('/', async function (req, res, next) {
    try {
        const direction = req.query.dir; // "to" or "from"
        const id = req.query.id; // user id

        // If 'direction' is not 'to' or 'from', return an error
        if (direction !== 'to' && direction !== 'from') {
            return res.status(400).send('Invalid direction parameter');
        }

        // If 'id' is not provided, return an error
        if (!id) {
            return res.status(400).send('Missing id parameter');
        }

        // Depending on the direction, adjust the foreign key and alias
        const foreignKey = direction === 'to' ? 'likeTo' : 'likeFrom';
        const alias = direction === 'to' ? 'likeToUser' : 'likeFromUser';

        // Find all likes with the corresponding foreign key
        const likes = await Like.findAll({
            where: {
                [foreignKey]: id,
            },
            include: [
                {
                    model: User,
                    as: 'likeToUser',
                    foreignKey: 'likeToUser',
                    include: [{
                        model: University,
                        as: 'university' // use the same alias as specified when defining the association
                    }, {
                        model: Interest,
                        through: 'UserInterest',
                        as: 'interests'
                    }]
                },
                {
                    model: User,
                    as: 'likeFromUser',
                    foreignKey: 'likeFromUser',
                    nclude: [{
                        model: University,
                        as: 'university' // use the same alias as specified when defining the association
                    }, {
                        model: Interest,
                        through: 'UserInterest',
                        as: 'interests'
                    }]
                }
            ]
        });

        res.json(likes);
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
});

router.post('/', async function (req, res, next) {
    try {
        const { likeFrom, likeTo } = req.body;

        const [like, created] = await Like.findOrCreate({
            where: { likeFrom, likeTo }
        });

        if (created) {
            res.json({ message: "Like created" });
        } else {
            res.json({ message: "Like already exists" });
        }
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
});

router.delete('/', async function (req, res, next) {
    try {
        const { likeFrom, likeTo } = req.body;

        // Find the Like with the given likeFrom and likeTo
        const like = await Like.findOne({
            where: { likeFrom, likeTo }
        });

        // If the Like does not exist, return an error
        if (!like) {
            return res.status(404).send('Like not found');
        }

        // Delete the Like
        await like.destroy();

        res.json({ message: "Like deleted" });
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;
