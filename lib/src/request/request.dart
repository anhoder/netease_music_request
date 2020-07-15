part of request;

enum METHOD {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE
}

const METHOD_MAPPING = {
  METHOD.GET: 'GET',
  METHOD.POST: 'POST',
  METHOD.PUT: 'PUT',
  METHOD.PATCH: 'PATCH',
  METHOD.DELETE: 'DELETE',
};

enum CRYPTO {
  WEAPI,
  LINUX_API,
  EAPI
}

abstract class Request {

  static Dio dio;
  static PersistCookieJar cookieJar;
  static CookieManager cookieManager;
  static String cookieDir;

  String BASE64_PRESET_KEY = base64.encode(utf8.encode(PRESET_KEY));
  String BASE64_IV = base64.encode(utf8.encode(IV));
  String BASE64_LINUX_API_KEY = base64.encode(utf8.encode(LINUX_API_KEY));
  String BASE64_EAPI_KEY = base64.encode(utf8.encode(EAPI_KEY));

  Request() {
    var env = Platform.environment;
    if (cookieDir == null) {
      if (Platform.isWindows) {
        cookieDir = '${env['USERPROFILE'].toString()}${Platform.pathSeparator}.musicfox${Platform.pathSeparator}cookies';
      } else {
        cookieDir = '${env['HOME'].toString()}${Platform.pathSeparator}.musicfox${Platform.pathSeparator}cookies';
      }
    }
    var directory = Directory(cookieDir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    dio = Dio();
    cookieJar = PersistCookieJar(dir: cookieDir);
    cookieManager = CookieManager(cookieJar);
    dio.interceptors.add(cookieManager);
  }

  Future<Response> request(METHOD method, String url, Map<dynamic, dynamic> data, Map<dynamic, dynamic> options) {

    // headers
    var headers = {'User-Agent': getUserAgent(options.containsKey('ua') ? options['ua'] : null)};
    if (method == METHOD.POST) {
      headers['Content-Type'] = 'application/x-www-form-urlencoded';
    }
    if (url.contains('music.163.com')) {
      headers['Referer'] = 'https://music.163.com';
    }
    if (options.containsKey('cookie') && options['cookie'] is Map<String, dynamic>) {
      options['cookie'].forEach((key, value) {
        cookieJar.saveFromResponse(Uri.parse(url), [Cookie(key, value)]);
      });
    }
    var cookie = cookieJar.loadForRequest(Uri.parse(url));
    if (options.containsKey('crypto')) {
      if (options['crypto'] == CRYPTO.WEAPI) {
        var match = RegExp(r'_csrf=([^(;|$)]+)').firstMatch(cookie.toString());
        data['csrf_token'] = match != null && match.groupCount >= 1 ? match.group(1) : '';
        data = weapiEncrypt(data);
        url = url.replaceFirst(RegExp(r'/\w*api/'), '/weapi/');
      } else if (options['crypto'] == CRYPTO.LINUX_API) {
        data = linuxEncrypt({
          'method': METHOD_MAPPING[method],
          'url': url.replaceFirst(RegExp(r'/\w*api/'), '/api/'),
          'params': data
        });
        headers['User-Agent'] = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36';
        url = 'https://music.163.com/api/linux/forward';
      } else if (options['crypto'] == CRYPTO.EAPI) {
        var cookieMap = {};
        cookie.forEach((value) {
          cookieMap[value.name] = value.value;
        });
        var csrfToken = '';
        var header = {};
        csrfToken = cookieMap.containsKey('__csrf') ? cookieMap['__csrf'] : '';
        header = {
          'osver': cookieMap.containsKey('osver') ? cookieMap['osver'] : '', //系统版本
          'deviceId': cookieMap.containsKey('deviceId') ? cookieMap['deviceId'] : '', //encrypt.base64.encode(imei + '\t02:00:00:00:00:00\t5106025eb79a5247\t70ffbaac7')
          'appver': cookieMap.containsKey('appver') ? cookieMap['appver'] : '6.1.1', // app版本
          'versioncode': cookieMap.containsKey('versioncode') ? cookieMap['versioncode'] : '140', //版本号
          'mobilename': cookieMap.containsKey('mobilename') ? cookieMap['mobilename'] : '', //设备model
          'buildver': cookieMap.containsKey('buildver') ? cookieMap['buildver'] : DateTime.now().toString().substring(0, 10),
          'resolution': cookieMap.containsKey('resolution') ? cookieMap['resolution'] : '1920x1080', //设备分辨率
          '__csrf': csrfToken,
          'os': cookieMap.containsKey('os') ? cookieMap['os'] : 'android',
          'channel': cookieMap.containsKey('channel') ? cookieMap['channel'] : '',
          'requestId': '${DateTime.now()}_${Random().nextInt(1000).toString().padLeft(4, '0')}'
        };
        if (cookieMap.containsKey('MUSIC_U')) header['MUSIC_U'] = cookieMap['MUSIC_U'];
        if (cookieMap.containsKey('MUSIC_A')) header['MUSIC_A'] = cookieMap['MUSIC_A'];
        data['header'] = header;
        data = eapiEncrypt(options['url'], data);
        url = url.replaceFirst(RegExp(r'/\w*api/'), '/eapi/');
      }

    }
    var requestOptions = Options(
      method: METHOD_MAPPING[method],
      sendTimeout: 2000,
      receiveTimeout: 10000,
      headers: headers,
    );
    if (method == METHOD.POST) requestOptions.contentType = 'application/x-www-form-urlencoded';
    return dio.request(url, data: data, options: requestOptions).then((response) {
      if (response.statusCode == 301) throw ResponseException('请先登录');
      if (response.statusCode != 200) throw ResponseException('{code: ${response.statusCode}, message: ${response.statusMessage}}');
      if (!(response.data is Map)) {
        try {
          var responseData = JsonDecoder().convert(response.data);
          response.data = responseData;
        } catch (e) {
          throw ResponseException('响应内容错误或为空');
        }
      }
      return response;
    });
  }

  Map<String, String> weapiEncrypt(Object data) {
    var json = JsonEncoder().convert(data);
    var secretKey = getSecretKey();
    var reversedKey = secretKey.reversed.toList();
    return {
      'params': aesEncrypt(aesEncrypt(json, ModeAES.cbc, BASE64_PRESET_KEY, BASE64_IV), ModeAES.cbc, base64.encode(secretKey), BASE64_IV),
      'encSecKey': hex.encode(base64.decode(rsaEncrypt(utf8.decode(reversedKey), RSA_PUBLIC_KEY)))
    };
  }

  Map<String, String> linuxEncrypt(Object data) {
    var json = JsonEncoder().convert(data);
    var base64Json = base64.encode(utf8.encode(json));
    return {
      'eparams': hex.encode(base64.decode(aesEncrypt(base64Json, ModeAES.ecb, BASE64_LINUX_API_KEY, ''))).toUpperCase()
    };
  }

  Map<String, String> eapiEncrypt(String url, Object data) {
    var json = JsonEncoder().convert(data);
    var message = 'nobody${url}use${json}md5forencrypt';
    var digest = hex.encode(base64.decode(HashCrypt(ModeHash.MD5).hash(message)));
    var res = '${url}-36cd479b6b5-${json}-36cd479b6b5-${digest}';
    var base64Res = base64.encode(utf8.encode(res));
    return {
      'params': hex.encode(base64.decode(aesEncrypt(base64Res, ModeAES.ecb, BASE64_EAPI_KEY, ''))).toUpperCase()
    };
  }

  String eapiDecrypt(String data) => aesDecrypt(data, ModeAES.ecb, BASE64_EAPI_KEY, '');

  List<int> getSecretKey() => List<int>.generate(16, (i) => Random().nextInt(256)).map((e) => BASE62.codeUnitAt(e % 62)).toList();
}