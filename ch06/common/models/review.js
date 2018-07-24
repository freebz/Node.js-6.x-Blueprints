'use strict';

module.exports = function(Review) {
    // 종단점/메서드 비활성화시키기
    Review.disableRemoteMethod("count", true);
    Review.disableRemoteMethod("exists", true);
    Review.disableRemoteMethod("findOne", true);
    Review.disableRemoteMethod("createChangeStream", true);
    Review.disableRemoteMethod("updateAll", true);
};
