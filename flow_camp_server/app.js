var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var express = require('express');
var bodyParser = require('body-parser');


const { sequelize } = require('./models');

var app = express();

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

app.use('/', indexRouter);
app.use('/users',authenticateToken, usersRouter);
app.use('/signin', signinRouter);
app.use('/signup', signupRouter);
app.use('/test', testRouter);
app.use('/me',authenticateToken, meRouter);
app.use('/users',authenticateToken, usersRouter);

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

module.exports = app;
