part of request;

class Artist extends Request {
  /// 获取歌手单曲
  Future getSongs(int artistId) {
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/artist/${artistId}', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取歌手专辑
  Future getAlbums(int artistId, {int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'total': true
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/artist/albums/${artistId}', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取歌手描述
  Future getDescription(int artistId) {
    var data = <String, dynamic>{
      'id': artistId
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/artist/introduction', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取相似歌手
  Future getSimiArtists(int artistId) {
    var data = <String, dynamic>{
      'artistid': artistId
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/discovery/simiArtist', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取热门歌手
  Future getHotArtists({int limit = 50, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'total': true
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/artist/top', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取歌手榜
  Future getTopArtists({int limit = 100, int offset = 0}) {
    var data = <String, dynamic>{
      'type': 1,
      'limit': limit,
      'offset': offset,
      'total': true
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/toplist/artist', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}