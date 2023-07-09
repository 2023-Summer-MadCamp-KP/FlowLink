// ./routes/signin.js

var express = require('express');
var router = express.Router();
var jwt = require('jsonwebtoken');

router.get('/', function(req, res, next) {
  res.send('GET request for signin');
});

router.post('/', function(req, res, next) {
  // 이 부분에서 로그인 인증을 수행한 후, 유효한 사용자인지 확인하는 로직을 작성합니다.
  // 인증이 성공하면 토큰을 발급하고 클라이언트에게 반환합니다.

  // 예시로 고정된 토큰 값을 발급하는 로직을 작성합니다.
  // 실제로는 사용자 인증 정보를 기반으로 토큰을 생성해야 합니다.
  var user = {
    id: 1,
    username: req.body.username
  };

  // 토큰을 생성합니다.
  var token = jwt.sign(user, 'your_secret_key', { expiresIn: 0 });

  // 발급된 토큰을 클라이언트에게 반환합니다.
  res.setHeader('Authorization', 'Bearer ' + token);
  res.json({ message: '로그인 성공' });
});

module.exports = router;
