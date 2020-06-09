part of request;

const COMMENT_TYPES = [
  'R_SO_4_', //  歌曲
  'R_MV_5_', //  MV
  'A_PL_0_', //  歌单
  'R_AL_3_', //  专辑
  'A_DJ_1_', //  电台
  'R_VI_62_', //  视频
];

class Comment extends Request {
  /// 给评论点赞
  Future likeComment(int type, int relaId, int commentId, {bool isLike = true}) {
    var data = <String, dynamic>{
      'threadId': '${COMMENT_TYPES[type]}${relaId}',
      'commentId': commentId,
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/v1/comment/${isLike ? 'like' : 'unlike'}', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 评论
  Future comment(int type, int relaId, String content) {
    var data = <String, dynamic>{
      'threadId': '${COMMENT_TYPES[type]}${relaId}',
      'content': content
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/resource/comments/add', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 回复评论
  Future reply(int type, int relaId, int commentId, String content) {
    var data = <String, dynamic>{
      'threadId': '${COMMENT_TYPES[type]}${relaId}',
      'commentId': commentId,
      'content': content
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/resource/comments/reply', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 删除评论
  Future deleteComment(int type, int relaId, int commentId) {
    var data = <String, dynamic>{
      'threadId': '${COMMENT_TYPES[type]}${relaId}',
      'commentId': commentId
    };

    return request(METHOD.POST, 'https://music.163.com/weapi/resource/comments/delete', data, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }
}