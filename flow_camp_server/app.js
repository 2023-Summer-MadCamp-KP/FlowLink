var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var express = require('express');
var bodyParser = require('body-parser');
const http = require('http');


const { sequelize } = require('./models');

var app = express();



const server = http.createServer(app);
const socketIo = require('socket.io');
const io = socketIo(server);
io.on('connection', (socket) => {
  console.log('New client connected');
  socket.on('disconnect', () => {
    console.log('Client disconnected');
  }); 

  socket.emit('message', 'Hello from server!');
});
app.use((req, res, next) => {
  req.io = io;
  next();
});



server.listen(8080, () => {
  console.log('Server started on port 8080');
});

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');


sequelize.sync({ force: false }).then(() => {
  console.log(
    '데이터 베이스 연결 성공'
  );
}).catch((err) => { console.error(err); })



app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));
// parse application/json
app.use(bodyParser.json());

// ---------------------------------------
/////Add routes
var authenticateToken = require('./authenticateToken');
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var signinRouter = require('./routes/signin');
var signupRouter = require('./routes/signup');
var testRouter = require('./routes/test');
var meRouter = require('./routes/me');
var usersRouter = require('./routes/users');
var likeRouter = require('./routes/like');
var singoutRouter = require('./routes/signout');
var interestRouter = require("./routes/interest");
var universityRouter = require("./routes/university");
var infoRouter = require("./routes/info");

app.use('/api/', indexRouter);
app.use('/api/users',authenticateToken, usersRouter);
app.use('/api/signin', signinRouter);
app.use('/api/signup', signupRouter);
app.use('/api/test', testRouter);
app.use('/api/me',authenticateToken, meRouter);
app.use('/api/users',authenticateToken, usersRouter);
app.use('/api/like',authenticateToken, likeRouter);
app.use('/api/signout',authenticateToken, singoutRouter);
app.use('/api/interest', interestRouter);
app.use('/api/university', universityRouter);
app.use('/api/info', authenticateToken,infoRouter);

//--------------------------------

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

/// 웹소켓 설정 -------------




module.exports = {app,io};
