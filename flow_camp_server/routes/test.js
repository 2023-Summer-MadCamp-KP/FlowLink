var express = require('express');
var router = express.Router();

const { User } = require('../models');
const { Like } = require('../models');
const { Interest } = require('../models');
const { University } = require('../models');
const { sequelize } = require('../models');

router.get('/add', async function (req, res, next) {


  //테스트 대학 넣어주기
  for (let i = 0; i < 10; i++) {
    let key = i.toString();

  }
  await University.create({
    name: "GIST",
    major: "공과대학",
    confirmed: true,
  })
  await University.create({
    name: "고려대학교",
    major: "공과대학",
    confirmed: true,
  })
  await University.create({
    name: "UNIST",
    major: "공과대학",
    confirmed: true,
  })
  await University.create({
    name: "KAIST",
    major: "공과대학",
    confirmed: true,
  })
  await University.create({
    name: "한양대학교",
    major: "공과대학",
    confirmed: true,
  })
  await University.create({
    name: "성균관대학교",
    major: "공과대학",
    confirmed: true,
  })

  //테스트 유저 넣어주기
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
        universityId: (i % 5) + 1,
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
        universityId: (i % 5) + 1,
      })
    }
  }

  //테스트 흥미 넣어주기

  await Interest.create({
    name: "React",
    category: "프론트엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "React Native",
    category: "프론트엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Angular",
    category: "프론트엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Vue.js",
    category: "프론트엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Unity",
    category: "프론트엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Flutter",
    category: "프론트엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Kotlin",
    category: "프론트엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Java",
    category: "프론트엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Swift",
    category: "프론트엔드",
    confirmed: true,
  })

  await Interest.create({
    name: "Django",
    category: "백엔드",
    confirmed: true,
  })

  await Interest.create({
    name: "NestJs",
    category: "백엔드",
    confirmed: true,
  })

  await Interest.create({
    name: "Express",
    category: "백엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Flask",
    category: "백엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Ruby on Rails",
    category: "백엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "Spring",
    category: "백엔드",
    confirmed: true,
  })
  await Interest.create({
    name: "FastAPI",
    category: "백엔드",
    confirmed: true,
  })

  await Interest.create({
    name: "MySQL",
    category: "데이터베이스",
    confirmed: true,
  })
  await Interest.create({
    name: "MongoDB",
    category: "데이터베이스",
    confirmed: true,
  })

  await Interest.create({
    name: "머신러닝",
    category: "기타",
    confirmed: true,
  })

  await Interest.create({
    name: "데이터 사이언스",
    category: "기타",
    confirmed: true,
  })

  await Interest.create({
    name: "딥러닝",
    category: "기타",
    confirmed: true,
  })
  await Interest.create({
    name: "NFT",
    category: "기타",
    confirmed: true,
  })

  //사용자에게 흥미 넣어주기

  for (i = 1; i <= 1000; i++) {
    var random_number1 = Math.floor(Math.random() * 100) + 1;
    var random_number2 = Math.floor(Math.random() * 22) + 1;

    // 이미 존재하는지 확인
    var existingInterest = await sequelize.models.UserInterest.findOne({
      where: {
        UserId: random_number1,
        InterestId: random_number2
      }
    });

    // 이미 존재하는 경우 생성을 건너뜀
    if (existingInterest) {
      continue;
    }

    // 존재하지 않는 경우 생성
    await sequelize.models.UserInterest.create({
      UserId: random_number1,
      InterestId: random_number2,
    });
  }

  //서로 좋아요 누른 관계 설정
  for (i = 1; i <= 1000; i++) {
    var random_number1 = Math.floor(Math.random() * 100) + 1;
    var random_number2 = Math.floor(Math.random() * 100) + 1;

    // 이미 존재하는지 확인
    var existingInterest = await Like.findOne({
      where: {
        likeFrom: random_number1,
        likeTo: random_number2
      }
    });

    // 이미 존재하는 경우 생성을 건너뜀
    if (existingInterest) {
      continue;
    }

    // 존재하지 않는 경우 생성
    await Like.create({
      likeFrom: random_number1,
      likeTo: random_number2
    });
  }










  res.send("성공");
});

router.get('/adduser', async function (req, res, next) {


  //테스트 유저 넣어주기
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
        bio: "안녕하세요. 저는 " + key + "번째 유저입니다. 팀원을 찾고 있습니다.",
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
