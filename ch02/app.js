var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var swig = require('swig');

// 인덱스 컨트롤러 삽입
var index = require('./controllers/index');
// Band 컨트롤러 삽입
var bands = require('./controllers/band');
// User 컨트롤러 삽입
var users = require('./controllers/user');


var app = express();

// 뷰 엔진 설정
app.set('views', path.join(__dirname, 'views/pages'));

var swig = new swig.Swig();
app.engine('html', swig.renderFile);
app.set('view engine', 'html');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Defining routes and controllers functions
app.get('/', index.show);
// Band 목록과 생성에 대한 라우트 정의하기
app.get('/bands', bands.list);
// id로 Band 얻기
app.get('/band/:id', bands.byId);
// Band 만들기
app.post('/bands', bands.create);
// 수정하기
app.put('/band/:id', bands.update);
// id로 삭제하기
app.delete('/band/:id', bands.delete);
// User 목록과 생성에 대한 라우트 정의하기
app.get('/users', users.list);
app.post('/users', users.create);


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler

// development error handler
// will print stacktrace
if (app.get('env') === 'develpment') {
    app.use(function(err, req, res, next) {
	res.status(err.status || 500);
	res.render('error', {
	    message: err.message,
	    error: err
	});
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
	message: err.message,
	error: {}
    });
});


module.exports = app;
