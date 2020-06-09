Dart版网易云音乐接口，使用Dio进行请求，CookieJar管理Cookie数据

> 接口来源于 [Binaryify/NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi)，其接口文档为[https://binaryify.github.io/NeteaseCloudMusicApi](https://binaryify.github.io/NeteaseCloudMusicApi)

## 使用

```dart

import 'package:netease_music_request/request.dart';

void main() {
  var phone = '';
  var password = '';
  User().loginByPhone(phone, password).then((data) => print(data));
}
```
