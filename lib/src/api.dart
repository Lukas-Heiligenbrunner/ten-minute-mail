import 'mail.dart';
import 'http_request.dart';

class Api {
  final HttpRequest _http = HttpRequest();

  static const String _baseUrl = "https://10minutemail.com";
  static const _newEmail = "$_baseUrl/session/address";
  static const _messageAfter = "$_baseUrl/messages/messagesAfter/";
  static const _messageCount = "$_baseUrl/messages/messageCount";
  static const _secondsLeft = "$_baseUrl/session/secondsLeft";
  static const _reset = "$_baseUrl/session/reset";

  Future<int> fetchMessageCount() async {
    final resp = await _http.httpGetJson(_messageCount) as Map<String, dynamic>;
    return resp["messageCount"] as int;
  }

  Future<String> fetchAddress() async {
    final resp = await _http.httpGetJson(_newEmail) as Map<String, dynamic>;
    String adr = resp["address"];
    return adr;
  }

  Future<List<Mail>> fetchNewMails(int oldmessageCnt) async {
    final int msgCnt = await fetchMessageCount();

    if (msgCnt > oldmessageCnt) {
      final resp = await _http
          .httpGetJson(_messageAfter + (msgCnt - 1).toString()) as Iterable;

      final List<Mail> mails =
          List<Mail>.from(resp.map((model) => Mail.fromJson(model)));
      return mails;
    }
    return [];
  }

  Future<int> fetchRemainingTime() async {
    final resp = await _http.httpGetJson(_secondsLeft) as Map<String, dynamic>;
    final String secLeft = resp["secondsLeft"];
    return int.tryParse(secLeft) ?? 0;
  }

  Future<bool> resetTimeCounter() async {
    final resp = await _http.httpGetJson(_reset) as Map<String, dynamic>;
    final String success = resp["Response"];
    return success == "reset";
  }
}
