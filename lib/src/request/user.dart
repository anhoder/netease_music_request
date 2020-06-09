part of request;

class User extends Request {

  /// 手机登录
  Future loginByPhone(String phone, String password, {String ctcode = '86'}) {
    var data = <String, dynamic>{
      'phone': phone,
      'password': md5Hash(password),
      'countrycode': '',
      'rememberLogin': 'true'
    };
    return request(
      METHOD.POST, 
      'https://music.163.com/weapi/login/cellphone', 
      data, 
      {'crypto': CRYPTO.WEAPI, 'ua': 'pc', 'cookie': {'os': 'pc'}}
    ).then((response) => response.data);
  }

  /// 邮箱登录
  Future loginByEmail(String email, String password) {
    var data = <String, dynamic>{
      'username': email,
      'password': md5Hash(password),
      'rememberLogin': 'true'
    };
    return request(
      METHOD.POST, 
      'https://music.163.com/weapi/login', 
      data, 
      {'crypto': CRYPTO.WEAPI, 'ua': 'pc', 'cookie': {'os': 'pc'}}
    ).then((response) => response.data);
  }

  /// 刷新登录
  Future refreshLogin() {
    return request(METHOD.POST, 'https://music.163.com/weapi/login/token/refresh', {}, {'crypto': CRYPTO.WEAPI, 'ua': 'pc'}).then((response) => response.data);
  }

  /// 发送验证码
  Future sendCaptcha(String phone, {String ctcode = '86'}) {
    var data = <String, dynamic>{
      'ctcode': ctcode,
      'cellphone': phone,
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/sms/captcha/sent', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 校验验证码
  Future verifyCaptcha(String phone, String captcha, {String ctcode = '86'}) {
    var data = <String, dynamic>{
      'ctcode': ctcode,
      'captcha': captcha,
      'cellphone': phone,
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/sms/captcha/verify', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 注册或修改密码
  Future register(String phone, String captcha, String password, String nickname) {
    var data = <String, dynamic>{
      'nickname': nickname,
      'captcha': captcha,
      'phone': phone,
      'password': password,
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/register/cellphone', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 初始化昵称
  Future initProfile(String nickname) {
    var data = <String, dynamic>{
      'nickname': nickname,
    };
    return request(METHOD.POST, 'http://music.163.com/eapi/activate/initProfile', data, {'crypto': CRYPTO.EAPI, 'url': '/api/activate/initProfile'}).then((response) => response.data);
  }

  /// 检查手机号是否已注册
  Future existPhone(String phone, {String ctcode = '86'}) {
    var data = <String, dynamic>{
      'cellphone': phone,
      'countrycode': ctcode,
    };
    return request(METHOD.POST, 'http://music.163.com/eapi/cellphone/existence/check', data, {'crypto': CRYPTO.EAPI, 'url': '/api/cellphone/existence/check'}).then((response) => response.data);
  }

  /// 获取用户音乐信息（歌单数、收藏数...）
  Future getSubcount() {
    return request(METHOD.POST, 'https://music.163.com/weapi/subcount', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
  
  /// 重新绑定手机号
  Future rebind(String phone, String captcha, String oldCaptcha, {String ctcode = '86'}) {
    var data = <String, dynamic>{
      'phone': phone,
      'captcha': captcha,
      'oldcaptcha': oldCaptcha,
      'ctcode': ctcode,
    };
    return request(METHOD.POST, 'https://music.163.com/api/user/replaceCellphone', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 退出登录
  Future logout() {
    return request(METHOD.POST, 'https://music.163.com/weapi/logout', {}, {'crypto': CRYPTO.WEAPI, 'ua': 'pc'}).then((response) => response.data);
  }

  /// 获取用户详情
  Future getUserDetail(int uid) {
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/user/detail/${uid}', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 编辑用户信息, gender 0 保密 1 男 2 女
  Future updateProfile(int birthday, int provinceId, int cityId, int gender, String nickname, String signature) {
    var data = <String, dynamic>{
      'avatarImgId': '0',
      'birthday': birthday,
      'province': provinceId,
      'city': cityId,
      'gender': gender,
      'nickname': nickname,
      'signature': signature
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/user/profile/update', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取用户关注列表
  Future getUserFollows(int uid, {int limit = 30, int offset = 0, bool order = true}) {
    var data = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'order': order
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/user/getfollows/${uid}', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取用户粉丝列表
  Future getUserFans(int uid, {int limit = 30, int time = -1}) {
    var data = <String, dynamic>{
      'limit': limit,
      'userId': uid,
      'time': time
    };
    return request(METHOD.POST, 'https://music.163.com/eapi/user/getfolloweds/${uid}', data, {'crypto': CRYPTO.EAPI, 'url': '/api/user/getfolloweds'}).then((response) => response.data);
  }

  /// 关注与取消关注
  Future updateFollow(int uid, {bool follow = true}) {
    return request(METHOD.POST, 'https://music.163.com/weapi/user/${follow ? 'follow' : 'delfollow'}/${uid}', {}, {'crypto': CRYPTO.WEAPI, 'cookie': {'os': 'pc'}}).then((response) => response.data);
  }

  /// 获取用户播放记录,type: 1最近一周 0全部
  Future getUserPlayRecords(int uid, {int type = 1}) {
    var data = <String, dynamic>{
      'uid': uid,
      'type': type
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/v1/play/record', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 每日签到
  /*
    0为安卓端签到 3点经验, 1为网页签到,2点经验
    签到成功 {'android': {'point': 3, 'code': 200}, 'web': {'point': 2, 'code': 200}}
    重复签到 {'android': {'code': -2, 'msg': '重复签到'}, 'web': {'code': -2, 'msg': '重复签到'}}
    未登录 {'android': {'code': 301}, 'web': {'code': 301}}
  */
  Future sign({int type = 0}) {
    var data = <String, dynamic>{
      'type': type
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/point/dailyTask', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取喜欢音乐列表
  Future likelist(int uid) {
    var data = <String, dynamic>{
      'uid': uid
    };
    return request(METHOD.POST, 'https://music.163.com/weapi/song/like/get', data, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }

  /// 获取用户设置
  Future getSetting() {
    return request(METHOD.POST, 'https://music.163.com/api/user/setting', {}, {'crypto': CRYPTO.WEAPI}).then((response) => response.data);
  }
}