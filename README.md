# Dart版网易云音乐接口

使用Dio发起请求，CookieJar管理Cookie，可用于命令行程序、Flutter程序。

> 接口逻辑来源于 [Binaryify/NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi)
> 
> 其接口文档为[https://binaryify.github.io/NeteaseCloudMusicApi](https://binaryify.github.io/NeteaseCloudMusicApi)

本项目使用Dart实现其接口逻辑，并在其基础上使用CookieJar管理Cookie信息

## 使用

```dart

import 'package:netease_music_request/request.dart';

void main() {
  var phone = '';
  var password = '';
  User().loginByPhone(phone, password).then((data) => print(data));
}
```
