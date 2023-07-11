var express = require('express');
var router = express.Router();

const { User } = require('../models');
const { Like } = require('../models');
const {Interest} =require('../models');

router.get('/adduser', async function (req, res, next) {
  for (let i = 1; i <= 100; i++) {
    let key = i.toString();
    if (i < 10) {
      await User.create({

        uid: key,
        password: key + key,
        platform: "normal",
        infoConfirmed: true,
        name: '유저' + i,
        prtcpntYear: 202324,
        gradOf: 20190204,
        infoConfirmed: true,
      })
    }
    else {
      await User.create({

        uid: key,
        password: key + key,
        platform: "normal",
        infoConfirmed: true,
        name: '유저' + i,
        prtcpntYear: 202321,
        gradOf: 20190204,
        infoConfirmed: true,
      })
    }
  }

  res.send();
});

router.get('/addlike', async function (req, res, next) {
  const user = await User.findOne({ where: { id: 1 } });
  const user2 = await User.findOne({ where: { id: 2 } });

  const [like, created] = await Like.findOrCreate({
    where: { likeFrom: user.id, likeTo: user2.id }
  });

  if (created) {
    res.json({ message: "Like created" });
  } else {
    res.json({ message: "Like already exists" });
  }
  // try {
  //   const [user, created] = await User.findOrCreate({
  //     where: { username: 'sdepold' },
  //     defaults: { job: 'Technical Lead JavaScript' },
  //     transaction
  //   });

  //   // If the execution reaches this line, the transaction has been successfully committed
  //   await transaction.commit();
  // } catch (error) {
  //   // If the execution reaches this line, an error occurred.
  //   // The transaction has been rolled back automatically
  //   await transaction.rollback();
  // }
});


router.get('/addinterest', async function (req, res, next) {
  for (let i = 0; i < 30; i++) {
    let key = i.toString();
    await Interest.create({
      name: "취미" + key,
      category: "카테고리" + Math.floor(i / 10).toString(),
      confirmed: true,
    })
  }
  res.send();
});

module.exports = router;
