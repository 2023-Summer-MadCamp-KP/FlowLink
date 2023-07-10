// ./routes/signin.js

var express = require('express');
var router = express.Router();
var jwt = require('jsonwebtoken');
const { User } = require('../models');

router.get('/', function (req, res, next) {
  res.send('GET request for signin');
});

router.post('/', async function (req, res, next) {
  // 이 부분에서 로그인 인증을 수행한 후, 유효한 사용자인지 확인하는 로직을 작성합니다.
  // 인증이 성공하면 토큰을 발급하고 클라이언트에게 반환합니다.

  try {
    const { uid, password, platform } = req.body;
    const user = await User.findOne({ where: { uid: uid, platform: platform } });
    if (!user) {
      // 사용자가 없을 경우 에러를 발생시킵니다.
      return res.status(401).json({ message: '인증 실패: 사용자를 찾을 수 없습니다.' });
    }
    if (user.password !== password) {
      // 비밀번호가 일치하지 않을 경우 에러를 발생시킵니다.
      return res.status(401).json({ message: '인증 실패: 비밀번호가 일치하지 않습니다.' });
    }
    var token = jwt.sign({ uid: user.uid, platform: user.platform },
      'your_secret_key', { expiresIn: '100h' });

    user.token = token;
    await user.save();

    res.setHeader('Authorization', 'Bearer ' + token);
    res.json({ message: '로그인 성공', token: token });

  } catch (error) {
    console.error(error);
    next(error);
  }



  // 예시로 고정된 토큰 값을 발급하는 로직을 작성합니다.
  // 실제로는 사용자 인증 정보를 기반으로 토큰을 생성해야 합니다.


  // 토큰을 생성합니다.
  // var token = jwt.sign(user, 'your_secret_key', { expiresIn: 0 });

  // // 발급된 토큰을 클라이언트에게 반환합니다.
  // res.setHeader('Authorization', 'Bearer ' + token);
  // res.json({ message: '로그인 성공' });
});

module.exports = router;
