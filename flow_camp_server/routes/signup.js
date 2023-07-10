var express = require('express');
var router = express.Router();
var mysql = require('mysql');

// MySQL 연결 설정
var connection = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '!@Mysq0114',
  database: 'nodejs'
});

// 회원 가입 POST 요청 처리
router.post('/', function(req, res, next) {
  var email = req.body.email;
  var password = req.body.password;

  var sql = 'INSERT INTO user (email, password) VALUES (?, ?)';
  var values = [email, password];

  connection.query(sql, values, function(err, result) {
    if (err) {
      console.error('회원 가입 중 오류 발생:', err);
      res.sendStatus(500);
      return;
    }

    console.log('회원 가입이 완료되었습니다.');
    res.sendStatus(200);
  });
});

module.exports = router;
