var jwt = require('jsonwebtoken');
const { User } = require('./models');
const { University } = require('./models');
const {Interest} =require('./models');

// Middleware to authenticate the user
async function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    console.log(token);

    if (!token) return res.sendStatus(401);

    jwt.verify(token, 'your_secret_key', async (err, user) => {
        if (err) return res.sendStatus(403);

        try {
            const dbUser = await User.findOne({
                where: {
                    id: user.id
                },
                include: [{
                    model: University,
                    as: 'university' // use the same alias as specified when defining the association
                },
                {
                    model: Interest,
                    through: 'UserInterest',
                    as: 'interests'
                }]
            });

            if (!dbUser) {
                return res.sendStatus(404);
            }

            req.user = dbUser;
            next();
        } catch (e) {
            console.error(e);
            res.sendStatus(500);
        }
    });
}

module.exports = authenticateToken;
