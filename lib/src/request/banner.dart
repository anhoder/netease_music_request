part of request;

const TYPES = [
  'pc',
  'android',
  'iphone',
  'ipad'
];

class Banner extends Request {
  /// 获取Banner
  Future getBanners({int type = 0}) {
    var data = <String, dynamic>{
      'clientType': TYPES[type],
    };

    return request(METHOD.POST, 'https://music.163.com/api/v2/banner/get', data, {'crypto': CRYPTO.LINUX_API}).then((response) => response.data);
  }
}