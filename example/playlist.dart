import 'package:netease_music_request/request.dart';

void main(List<String> args) {
  var userId = 1243;
  Playlist().gteUserPlaylists(userId).then((data) => print(data));
}