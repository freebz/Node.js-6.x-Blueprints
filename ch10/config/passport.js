// 패스포트 모듈 로드
var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;

// 사용자 모델 로드
var User = require('../models/User');
passport.serializeUser(function(user, done) {
    // 세션용으로 사용자 직렬화
    done(null, user.id);
});
passport.deserializeUser(function(id, done) {
    // 사용자 역질렬화
    User.findById(id, function(err, user) {
	done(err, user);
    });
});

// local strategy 사용
passport.use(new LocalStrategy({ usernameField: 'email' },
    function(email, password, done) {
	User.findOne({ email: email }, function(err, user) {
	    if (!user) {
		// 에러 확인하고 메시지 가져오기
		return done(null, false, {msg: 'The email: ' + email +' is already taken.'});
	    }
	    user.comparePassword(password, function(err, isMatch) {
		if (!isMatch) {
		    // 에러 확인하고 메시지 가져오기
		    return done(null, false, { msg:'Invalid email or password'});
		}
		return done(null, user);
	    });
	});
    }));
