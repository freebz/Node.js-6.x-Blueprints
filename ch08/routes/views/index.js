var keystone = require('keystone');

exports = module.exports = function (req, res) {

    var view = new keystone.View(req, res);
    var locals = res.locals;

    // locals.section은 헤더 네비게이션에서 현제 선택된 항목을 설정하는 데 사용된다.
    locals.section = 'home';

    // 인덱스에 게시물을 보여주는 코드 추가하기
    locals.data = {
	posts: []
    };
    
    view.on('init', function(next) {
	
	var q = keystone.list('Post').model.find()
	    .where('state', 'published')
	    .sort('-publishedDate')
	    .populate('author')
	    .limit('4');
	
	q.exec(function(err, results) {
	    locals.data.posts = results;
	    next(err);
	});
    });
    
    // 뷰 렌더링
    view.render('index');
};
