
import 'package:netease_music_request/request.dart';

void main() {
  var phone = '';
  var password = '';
  User().loginByPhone(phone, password).then((data) => print(data));
}
