import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequest {
  final http.Client _client = http.Client();
  final Map<String, String> _headers = {};

  Future<dynamic> httpGetJson(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.get(uri, headers: _headers);
      _updateCookie(response);
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (e) {
      return {};
    }
  }

  void _updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      _headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
