part of request;

class Song extends Request {
  /// 获取歌曲播放链接
  Future getSongUrlByLinux(int songId, {int br = 999000}) {
    var cookie = Request.cookieJar.loadForRequest(Uri.parse('https://music.163.com'));
    var exists = false;
    for (var i = 0; i < cookie.length; i++) {
      if (cookie[i].name == 'MUSIC_U') {
        exists = true;
        break;
      }
    }

    var options = <String, dynamic>{'crypto': CRYPTO.LINUX_API, 'cookie': {'os': 'pc'}};
    if (!exists) {
      options['cookie']['_ntes_nuid'] = hex.encode(List<int>.generate(16, (i) => Random().nextInt(256)));
    }

    var data = <String, dynamic>{
      'ids': [songId].toString(),
      'br': br
    };

    return request(METHOD.POST, 'https://music.163.com/api/song/enhance/player/url', data, options).then((response) => response.data);
  }

  /// 获取歌曲播放链接
  Future getSongUrlByWeb(int songId, {int br = 999000}) {
    var data = <String, dynamic>{
      'ids': [songId].toString(),
      'br': br
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/song/enhance/player/url', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取歌曲详情
  Future getSongDetail(List<int> songIds, {int br = 999000}) {
    var songIdMapList = <Map>[];
    songIds.forEach((songId) {
      songIdMapList.add({'id': songId});
    });
    var data = <String, dynamic>{
      'ids': songIds.toString(),
      'c': songIdMapList.toString()
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/v3/song/detail', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取歌词
  Future getLyric(int songId) {
    var data = <String, dynamic>{
      'id': songId,
      'lv': -1,
      'kv': -1,
      'tv': -1
    };

    return request(METHOD.POST, 'https://music.163.com/api/song/lyric', data, {'crypto': CRYPTO.LINUX_API, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取评论
  Future getComments(int songId, {int limit = 20, int offset = 0, int before = 0}) {
    var data = <String, dynamic>{
      'rid': songId,
      'limit': limit,
      'offset': offset,
      'beforeTime': before
      };

    return request(METHOD.POST, 'https://music.163.com/api/v1/resource/comments/R_SO_4_${songId}', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取热评
  Future getHotComments(int songId, {int limit = 20, int offset = 0, int before = 0}) {
    var data = <String, dynamic>{
      'rid': songId,
      'limit': limit,
      'offset': offset,
      'beforeTime': before
      };

    return request(METHOD.POST, 'https://music.163.com/weapi/v1/resource/hotcomments/R_SO_4_${songId}', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取相似歌曲
  Future getSimiSongs(int songId, {int limit = 50, int offset = 0}) {
    var data = <String, dynamic>{
      'songid': songId,
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/discovery/simiSong', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取最近听过该歌的5歌用户
  Future getRecentUsers(int songId, {int limit = 50, int offset = 0}) {
    var data = <String, dynamic>{
      'songid': songId,
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/discovery/simiUser', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
  
  /// 获取每日推荐歌曲
  Future getRecommendSongs() {
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/discovery/recommend/songs', {'total': true}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取私人FM
  Future getPersonalFMSongs() {
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/radio/get', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 私人FM歌曲移至垃圾桶
  Future trashFMSong(int songId) {
    var data = <String, dynamic>{
      'songId': songId
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/radio/trash/add?alg=RT&songId=${songId}&time=25', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 喜欢歌曲
  Future like(int songId, {bool isLike = true}) {
    var data = <String, dynamic>{
      'trackId': songId,
      'like': isLike,
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/radio/like?alg=itembased&trackId=${songId}&time=25', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取推荐的新歌曲
  Future getRecommandNewSongs() {
    var data = <String, dynamic>{
      'type': 'recommend',
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/personalized/newsong', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}