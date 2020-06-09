part of request;

class Player extends Request {
  /* 
    type 取值
    1:男歌手
    2:女歌手
    3:乐队

    area 取值
    -1:全部
    7华语
    96欧美
    8:日本
    16韩国
    0:其他

    initial 取值 a-z/A-Z
  */
  Future getCategories(String initial, {int area = -1, int offset = 0, int limit = 30, int type = 1}) {
    var data = <String, dynamic>{
      'initial': initial.toUpperCase().codeUnitAt(0),
      'offset': offset,
      'limit': limit,
      'total': true,
      'type': type,
      'area': area,
    };
    return request(METHOD.POST, 'https://music.163.com/api/v1/artist/list', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 收藏或取消收藏歌手
  Future subPlayer(int artistId, {bool sub = true}) {
    var data = <String, dynamic>{
      'artistId': artistId,
      'artistIds': [artistId].toString()
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/artist/${sub ? 'sub' : 'unsub'}', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 歌手热门50首
  Future topSongs(int artistId) {
    var data = <String, dynamic>{
      'id': artistId,
    };
    return request(METHOD.POST, 'https://music.163.com/api/artist/top/song', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 收藏的歌手列表
  Future getSubPlayerLists({int limit = 25, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'total': true
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/artist/sublist', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}