import 'package:http/http.dart' as http;

class Repository {
  String _baseUrl = "https://yoga.infous.xyz/api";

  httpGet(String api) async {
    return await http.get(_baseUrl + "/" + api);
  }
}
