part of request;

class Message extends Request {
  /// 获取私信
  Future getPrivateMessage({int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'total': true
    };
    return request(METHOD.POST, 'https://music.163.com/api/msg/private/users', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 发送消息，type: text文本 playlist带歌单
  Future send(String type, String message, List<int> $userIds, [int playlistId]) {
    var data = <String, dynamic>{
      'id': playlistId ?? '',
      'type': type,
      'msg': message,
      'userIds': $userIds.toString()
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/msg/private/send', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取评论
  Future getComments(int userId, {int limit = 30, int before = -1}) {
    var data = <String, dynamic>{
      'limit': limit,
      'before': before,
      'total': true,
      'uid': userId
    };
    return request(METHOD.POST, 'https://music.163.com/api/v1/user/comments/${userId}', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取@我
  Future getAtMe({int limit = 30, int offset = 0}) {
    var data = <String, dynamic>{
      'limit': limit,
      'total': true,
      'offset': 0
    };
    return request(METHOD.POST, 'https://music.163.com/api/forwards/get', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取通知
  Future getNotices({int limit = 30, int time = -1}) {
    var data = <String, dynamic>{
      'limit': limit,
      'time': time
    };
    return request(METHOD.POST, 'https://music.163.com/api/msg/notices', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}