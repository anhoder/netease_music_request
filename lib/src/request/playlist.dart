part of request;

const TOP_PLAYLISTS = <int, String>{
  3779629: '云音乐新歌榜',
  3778678: '云音乐热歌榜',
  2884035: '云音乐原创榜',
  19723756: '云音乐飙升榜',
  10520166: '云音乐电音榜',
  180106: 'UK排行榜周榜',
  60198: '美国Billboard周榜',
  21845217: 'KTV嗨榜',
  11641012: 'iTunes榜',
  120001: 'Hit FM Top榜',
  60131: '日本Oricon周榜',
  3733003: '韩国Melon排行榜周榜',
  60255: '韩国Mnet排行榜周榜',
  46772709: '韩国Melon原声周榜',
  112504: '中国TOP排行榜(港台榜)',
  64016: '中国TOP排行榜(内地榜)',
  10169002: '香港电台中文歌曲龙虎榜',
  4395559: '华语金曲榜',
  1899724: '中国嘻哈榜',
  27135204: '法国 NRJ EuroHot 30周榜',
  112463: '台湾Hito排行榜',
  3812895: 'Beatport全球电子舞曲榜',
  71385702: '云音乐ACG音乐榜',
  991319590: '云音乐说唱榜,',
  71384707: '云音乐古典音乐榜',
  1978921795: '云音乐电音榜',
  2250011882: '抖音排行榜',
  2617766278: '新声榜',
  745956260: '云音乐韩语榜',
  2023401535: '英国Q杂志中文版周榜',
  2006508653: '电竞音乐榜',
  2809513713: '云音乐欧美热歌榜',
  2809577409: '云音乐欧美新歌榜',
  2847251561: '说唱TOP榜',
  3001835560: '云音乐ACG动画榜',
  3001795926: '云音乐ACG游戏榜',
  3001890046: '云音乐ACG VOCALOID榜',
};

class Playlist extends Request {
  /// 获取用户歌单
  Future gteUserPlaylists(int uid, {int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'uid': uid,
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/user/playlist', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 批量更新歌单信息
  Future batchUpdatePlaylist(int id, String name, {String tags = '', String desc = ''}) {
    var data = <String, dynamic>{
      '/api/playlist/desc/update': '{"id":${id},"desc":"${desc}"}',
      '/api/playlist/tags/update': '{"id":${id},"tags":"${tags}"}',
      '/api/playlist/update/name': '{"id":${id},"name":"${name}"}'
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/batch', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 更新歌单名
  Future updatePlaylistName(int id, String name) {
    var data = <String, dynamic>{
      'id': id,
      'name': name
    };
    return request(METHOD.POST, 'http://interface3.music.163.com/eapi/playlist/update/name', data, {'crypto': CRYPTO.EAPI, 'url': '/api/playlist/update/name'}).then((response) => response.data);
  }

  /// 更新歌单标签
  Future updatePlaylistTags(int id, String tags) {
    var data = <String, dynamic>{
      'id': id,
      'tags': tags
    };
    return request(METHOD.POST, 'http://interface3.music.163.com/eapi/playlist/tags/update', data, {'crypto': CRYPTO.EAPI, 'url': '/api/playlist/tags/update'}).then((response) => response.data);
  }

  /// 调整歌单顺序
  Future updatePlaylistsOrder(List<int> ids) {
    var data = <String, dynamic>{
      'ids': ids.toString()
    };
    return request(METHOD.POST, 'https://music.163.com/api/playlist/order/update', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 调整歌曲顺序
  Future updateSongsOrder(int playlistId,List<int> ids) {
    var data = <String, dynamic>{
      'pid': playlistId,
      'trackIds': ids.toString(),
      'op': 'update'
    };
    return request(METHOD.POST, 'http://interface.music.163.com/api/playlist/manipulate/tracks', data, {'crypto': CRYPTO.WEAPI, 'url': '/api/playlist/desc/update'}).then((response) => response.data);
  }

  /// 获取歌单详情
  Future getPlaylistDetail(int playlistId, {int limit = 100000, int collectors = 8}) {
    var data = <String, dynamic>{
      'id': playlistId,
      'n': limit,
      's': collectors
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/v3/playlist/detail', data, {'crypto': CRYPTO.LINUX_API}).then((response) => response.data);
  }

  /// 心动模式
  Future getIntelligenceList(int playlistId, int songId, {int startMusicId, int count = 1}) {
    var data = <String, dynamic>{
      'playlistId': playlistId,
      'songId': songId,
      'startMusicId': startMusicId ?? songId,
      'count': count,
      'type': 'fromPlayOne',
    };
    return request(METHOD.POST, 'http://music.163.com/weapi/playmode/intelligence/list', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 歌单分类
  Future getPlaylistCats() {
    return request(METHOD.POST, 'https://music.163.com/weapi/playlist/catalogue', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 热门歌单分类
  Future getHotPlaylistCats() {
    return request(METHOD.POST, 'https://music.163.com/weapi/playlist/hottags', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取分类下的歌单 order: hot,new   cat: 全部,华语,欧美,日语,韩语,粤语,小语种,流行,摇滚,民谣,电子,舞曲,说唱,轻音乐,爵士,乡村,R&B/Soul,古典,民族,英伦,金属,朋克,蓝调,雷鬼,世界音乐,拉丁,另类/独立,New Age,古风,后摇,Bossa Nova,清晨,夜晚,学习,工作,午休,下午茶,地铁,驾车,运动,旅行,散步,酒吧,怀旧,清新,浪漫,性感,伤感,治愈,放松,孤独,感动,兴奋,快乐,安静,思念,影视原声,ACG,儿童,校园,游戏,70后,80后,90后,网络歌曲,KTV,经典,翻唱,吉他,钢琴,器乐,榜单,00后
  Future getCatPlaylists({String cat = '全部', String order = 'hot', int limit = 50, int offset = 0}) {
    var data = <String, dynamic>{
      'cat': cat,
      'order': order,
      'limit': limit,
      'offset': offset,
      'total': true
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/playlist/list', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取排行榜
  Future getRanks() {
    return request(METHOD.POST, 'https://music.163.com/api/toplist', {}, {'crypto': CRYPTO.LINUX_API}).then((response) => response.data);
  }

  /// 获取排行榜详情
  Future getRankDetail(int rankId) {
    var data = <String, dynamic>{
      'id': rankId,
      'n': 1000,
      's': 5,
      'shareUserId': 0,
    };
    return request(METHOD.POST, 'https://interface3.music.163.com/api/playlist/v4/detail', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取精品歌单，cat: 全部,华语,欧美,韩语,日语,粤语,小语种,运动,ACG,影视原声,流行,摇滚,后摇,古风,民谣,轻音乐,电子,器乐,说唱,古典,爵士
  Future getQualityPlaylists({String cat = '全部', int limit = 50, int before = 0}) {
    var data = <String, dynamic>{
      'cat': cat,
      'limit': limit,
      'lasttime': before, // 歌单updateTime
      'total': true
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/playlist/highquality/list', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 新建歌单 0为普通歌单 10为私密歌单
  Future createPlaylist(String name, {int privacy = 0}) {
    var data = <String, dynamic>{
      'name': name,
      'privacy': privacy
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/playlist/create', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 删除歌单
  Future deletePlaylist(int playlistId) {
    var data = <String, dynamic>{
      'ids': [playlistId].toString(),
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/playlist/remove', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 收藏、取消收藏歌单
  Future subscribePlaylist(int playlistId, {bool subscribe = true}) {
    var data = <String, dynamic>{
      'id': playlistId,
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/playlist/${subscribe ? 'subscribe' : 'unsubscribe'}', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取歌单收藏者
  Future getPlaylistSubscribers(int playlistId, {int limit = 20, int offset = 0}) {
    var data = <String, dynamic>{
      'id': playlistId,
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/playlist/subscribers', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 歌单增删歌曲
  Future playlistTracks(int playlistId, List<int> tracks, {bool isAdd = true}) {
    var data = <String, dynamic>{
      'op': isAdd ? 'add' : 'del',
      'pid': playlistId,
      'trackIds': tracks.toString()
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/playlist/manipulate/tracks', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取新歌一百首 type: 全部:0 华语:7 欧美:96 日本:8 韩国:16
  Future getNewSongs({int type = 0}) {
    var data = <String, dynamic>{
      'areaId': type,
      'total': true
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/v1/discovery/new/songs', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取评论
  Future getComments(int playlistId, {int limit = 20, int offset = 0, int before = 0}) {
    var data = <String, dynamic>{
      'rid': playlistId,
      'limit': limit,
      'offset': offset,
      'beforeTime': before
      };

    return request(METHOD.POST, 'https://music.163.com/weapi/v1/resource/comments/A_PL_0_${playlistId}', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取热评
  Future getHotComments(int playlistId, {int limit = 20, int offset = 0, int before = 0}) {
    var data = <String, dynamic>{
      'rid': playlistId,
      'limit': limit,
      'offset': offset,
      'beforeTime': before
      };

    return request(METHOD.POST, 'https://music.163.com/weapi/v1/resource/hotcomments/A_PL_0_${playlistId}', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取相似歌单
  Future getSimiPlaylists(int songId, {int limit = 50, int offset = 0}) {
    var data = <String, dynamic>{
      'songid': songId,
      'limit': limit,
      'offset': offset
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/discovery/simiPlaylist', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取每日推荐歌单
  Future getDailyRecommendPlaylists() {
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/discovery/recommend/resource', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取推荐歌单
  Future getRecommendPlaylists({int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'total': true,
      'n': 1000
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/personalized/playlist', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}