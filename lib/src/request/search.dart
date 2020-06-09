part of request;

class Search extends Request {
  /// 搜索, type: 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频, 1018:综合
  Future search(String keywords, {int type = 1, int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      's': keywords,
      'type': type,
      'limit': limit,
      'offset': offset
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/search/get', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取默认搜索关键词
  Future searchDefault() {
    return request(METHOD.POST, 'http://interface3.music.163.com/eapi/search/defaultkeyword/get', {}, {'crypto': CRYPTO.EAPI, 'url': '/api/search/defaultkeyword/get'}).then((response) => response.data);
  }

  /// 热搜(简略)
  Future searchHot() {
    var data = <String, dynamic>{
      'type': 1111
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/search/hot', data, {'crypto': CRYPTO.WEAPI, 'ua': 'mobile'}).then((response) => response.data);
  }

  /// 热搜(详细)
  Future searchHotDetail() {
    return request(METHOD.POST, 'https://music.163.com/weapi/hotsearchlist/get', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 搜索建议 type: mobile返回移动端数据
  Future searchSuggest({String keywords = '', String type = 'web'}) {
    var data = <String, dynamic>{
      's': keywords
    };
    var typeString = type == 'mobile' ? 'keyword' : 'web';
    return request(METHOD.POST, 'https://music.163.com/weapi/search/suggest/${typeString}', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 搜索多重匹配
  Future searchMultimatch({String keywords = '', int type = 1}) {
    var data = <String, dynamic>{
      's': keywords,
      'type': type
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/search/suggest/multimatch', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}