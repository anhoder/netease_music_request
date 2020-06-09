part of request;

class Cloud extends Request {
  /// 获取云盘
  Future getCloud({int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset,
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/cloud/get', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取云盘详情
  Future getCloudDetail(List<int> songIds) {
    var data = <String, dynamic>{
      'songIds': songIds.toString(),
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/cloud/get/byids', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 删除云盘音乐
  Future deleteCloudSong(int songId) {
    var data = <String, dynamic>{
      'songIds': [songId].toString(),
    };
    return request(METHOD.POST, 'http://music.163.com/weapi/cloud/del', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}