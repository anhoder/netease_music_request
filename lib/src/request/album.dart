part of request;

class Album extends Request {

  /// 获取专辑内容
  Future getAlbum(int albumId) {
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/album/${albumId}', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取评论
  Future getComments(int albumId, {int limit = 20, int offset = 0, int before = 0}) {
    var data = <String, dynamic>{
      'rid': albumId,
      'limit': limit,
      'offset': offset,
      'beforeTime': before
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/v1/resource/comments/R_AL_3_${albumId}', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取热评
  Future getHotComments(int albumId, {int limit = 20, int offset = 0, int before = 0}) {
    var data = <String, dynamic>{
      'rid': albumId,
      'limit': limit,
      'offset': offset,
      'beforeTime': before
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/v1/resource/hotcomments/R_AL_3_${albumId}', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 收藏专辑
  Future subAlbum(int albumId, {bool isSub = true}) {
    var data = <String, dynamic>{
      'id': albumId,
    };

    return request(METHOD.POST, 'https://music.163.com/api/album/${isSub ? 'sub' : 'unsub'}', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取已收藏专辑
  Future getSubAlbums({int limit = 25, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'total': true
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/album/sublist', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取新专辑, type: ALL,ZH,EA,KR,JP
  Future getNewAlbums({String type = 'ALL', int limit = 50, int offset = 0}) {
    var data = <String, dynamic>{
      'area': type,
      'limit': limit,
      'offset': offset,
      'total': true
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/album/new', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取热门新专辑
  Future getHotNewAlbums() {
    return request(METHOD.POST, 'https://music.163.com/api/discovery/newAlbum', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}