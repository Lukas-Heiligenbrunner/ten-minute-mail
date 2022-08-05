import 'dart:convert';

import 'mail.dart';
import 'package:http/http.dart' as http;

class TenMinuteMail {
  static const String baseUrl = "https://10minutemail.com";
  static const newEmail = "$baseUrl/session/address";
  static const messageAfter = "$baseUrl/messages/messagesAfter/";
  static const messageCount = "$baseUrl/messages/messageCount";

  List<Mail> _messages = [];
  int _msgCount = 0;
  late String _address = "";
  http.Client _client = http.Client();

  TenMinuteMail();

  List<Mail> getMails() {
    return _messages;
  }

  String getAddress(){
    return _address;
  }

  Future init() async {
    _client = http.Client();
    _messages = [];
    _msgCount = 0;

    var resp = await _httpGetJson(newEmail) as Map<String, dynamic>;
    String adr =  resp["address"];
    _address = adr;
  }

  Future<List<Mail>> fetchMails() async {
    int msgCnt = await _fetchMessageCount();

    if (msgCnt > _msgCount) {
      var resp = await _httpGetJson(messageAfter + (msgCnt - 1).toString()) as Iterable;

      final List<Mail> mails = List<Mail>.from(resp.map((model) => Mail.fromJson(model)));
      _messages.addAll(mails);
      _msgCount = msgCnt;
    }

    return _messages;
  }

  Future<int> _fetchMessageCount() async {
    var resp = await _httpGetJson(messageCount) as Map<String, dynamic>;
    return resp["messageCount"] as int;
  }

  Future<dynamic> _httpGetJson(String url) async {
    try {
      var uri = Uri.parse(url);
      var response = await _client.get(uri, headers: headers);
      updateCookie(response);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (e) {
      return {};
    }
  }
  Map<String, String> headers = {};

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
