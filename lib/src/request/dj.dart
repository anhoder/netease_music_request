part of request;

class Dj extends Request {
  /// 获取用户DJ
  Future getUserDjPrograms(int uid, {int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/dj/program/${uid}', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取评论
  Future getComments(int djId, {int limit = 20, int offset = 0, int before = 0}) {
    var data = <String, dynamic>{
      'rid': djId,
      'limit': limit,
      'offset': offset,
      'beforeTime': before
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/v1/resource/comments/A_DJ_1_${djId}', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取热评
  Future getHotComments(int djId, {int limit = 20, int offset = 0, int before = 0}) {
    var data = <String, dynamic>{
      'rid': djId,
      'limit': limit,
      'offset': offset,
      'beforeTime': before
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/v1/resource/hotcomments/A_DJ_1_${djId}', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取推荐的新电台
  Future getRecommandNewDjs() {
    return request(METHOD.POST, 'https://music.163.com/weapi/personalized/djprogram', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取推荐的新节目
  Future getRecommandNewPrograms({int limit = 10, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/program/recommend/v1', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取电台Banner
  Future getBanners() {
    return request(METHOD.POST, 'http://music.163.com/weapi/djradio/banner/get', {}, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取用户电台
  Future getUserDjs(int userId) {
    var data = <String, dynamic>{
      'userId': userId,
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/djradio/get/byuser', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取热门电台
  Future getHotDjs({int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/djradio/hot/v1', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取电台节目排行榜
  Future getProgramRank({int limit = 100, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/api/program/toplist/v1', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取24小时电台节目榜
  Future getProgram24Rank({int limit = 100}) {
    var data = <String, dynamic>{
      'limit': limit,
    };
    return request(METHOD.POST, 'https://music.163.com/api/djprogram/toplist/hours', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取24小时主播榜
  Future getAnchor24Rank({int limit = 100}) {
    var data = <String, dynamic>{
      'limit': limit,
    };
    return request(METHOD.POST, 'https://music.163.com/api/dj/toplist/hours', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取新人主播榜
  Future getNewAnchorRank({int limit = 100}) {
    var data = <String, dynamic>{
      'limit': limit,
    };
    return request(METHOD.POST, 'https://music.163.com/api/dj/toplist/newcomer', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取热门主播榜
  Future getHotAnchorRank({int limit = 100}) {
    var data = <String, dynamic>{
      'limit': limit,
    };
    return request(METHOD.POST, 'https://music.163.com/api/dj/toplist/popular', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取热门/新晋电台榜
  Future getDjRank({bool isHot = true, int limit = 100, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'type': isHot ? 1 : 0
    };
    return request(METHOD.POST, 'https://music.163.com/api/djradio/toplist', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取分类下热门电台
  Future getCatHotDjs(int cateId, {int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'cateId': cateId,
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/api/djradio/hot', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取电台分类
  Future getDjCategories() {
    return request(METHOD.POST, 'https://music.163.com/weapi/djradio/category/get', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取电台非热门分类
  Future getExcludehotCates() {
    return request(METHOD.POST, 'http://music.163.com/weapi/djradio/category/excludehot', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取推荐电台分类
  Future getRecommendDJCates() {
    return request(METHOD.POST, 'http://music.163.com/weapi/djradio/home/category/recommend', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取推荐电台
  Future getRecommendDjs() {
    return request(METHOD.POST, 'https://music.163.com/weapi/djradio/recommend/v1', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取分类下推荐电台
  Future getCateRecommendDjs(int cateId) {
    var data = <String, dynamic>{
      'cateId': cateId
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/djradio/recommend', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 订阅、取消订阅电台
  Future subDj(int djId, {bool isSub = true}) {
    var data = <String, dynamic>{
      'id': djId
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/djradio/${isSub ? 'sub' : 'unsub'}', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取订阅电台
  Future getSubDjs({int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'total': true
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/djradio/get/subed', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取付费精选电台
  Future getPayDjs({int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/djradio/home/paygift/list?_nmclfl=1', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取今日优选电台
  Future getTodayPerferedDjs({int page = 0}) {
    var data = <String, dynamic>{
      'page': page
    };
    return request(METHOD.POST, 'http://music.163.com/weapi/djradio/home/today/perfered', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取电台详情
  Future getDjDetail(int djId) {
    var data = <String, dynamic>{
      'id': djId
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/djradio/get', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取电台详情
  Future getDjPrograms(int djId, {bool asc = false, int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'radioId': djId,
      'limit': limit,
      'offset': offset,
      'asc': asc
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/dj/program/byradio', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取节目详情
  Future getProgramDetail(int programId) {
    var data = <String, dynamic>{
      'id': programId
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/dj/program/detail', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}