const jwt = require('jsonwebtoken');

router.get('/', function (req, res, next) {
  // 관련 토큰을 삭제하는 로직을 작성합니다.

  // 토큰을 클라이언트의 헤더에서 가져옵니다.
  const token = req.headers.authorization && req.headers.authorization.split(' ')[1];

  // 토큰이 존재하지 않는 경우, 이미 삭제된 경우 등의 처리를 원하는 경우 추가로 구현합니다.

  // 토큰을 검증하고 삭제하는 로직을 작성합니다.
  try {
    // 토큰을 검증하여 유효한지 확인합니다.
    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);

    // 토큰 삭제에 성공한 응답을 반환합니다.
    res.json({ message: 'Token deleted' });
  } catch (err) {
    // 토큰이 유효하지 않은 경우, 삭제 실패 등의 처리를 원하는 경우 추가로 구현합니다.
    console.error(err);
    res.status(500).json({ message: 'Token deletion failed' });
  }
});
