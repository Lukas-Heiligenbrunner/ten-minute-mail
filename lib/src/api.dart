import 'mail.dart';
import 'http_request.dart';

class _EndPoints {
  static const String baseUrl = "https://10minutemail.com";
  static const newEmail = "$baseUrl/session/address";
  static const messageAfter = "$baseUrl/messages/messagesAfter/";
  static const messageCount = "$baseUrl/messages/messageCount";
  static const secondsLeft = "$baseUrl/session/secondsLeft";
  static const reset = "$baseUrl/session/reset";
}

class Api {
  final HttpRequest _http = HttpRequest();

  Future<int> fetchMessageCount() async {
    final resp = await _http.httpGetJson(_EndPoints.messageCount)
        as Map<String, dynamic>;
    return resp["messageCount"] as int;
  }

  Future<String> fetchAddress() async {
    final resp =
        await _http.httpGetJson(_EndPoints.newEmail) as Map<String, dynamic>;
    String adr = resp["address"];
    return adr;
  }

  Future<List<Mail>> fetchNewMails(int oldmessageCnt) async {
    final int msgCnt = await fetchMessageCount();

    if (msgCnt > oldmessageCnt) {
      final resp = await _http.httpGetJson(
          _EndPoints.messageAfter + (msgCnt - 1).toString()) as Iterable;

      final List<Mail> mails =
          List<Mail>.from(resp.map((model) => Mail.fromJson(model)));
      return mails;
    }
    return [];
  }

  Future<int> fetchRemainingTime() async {
    final resp =
        await _http.httpGetJson(_EndPoints.secondsLeft) as Map<String, dynamic>;
    final String secLeft = resp["secondsLeft"];
    return int.tryParse(secLeft) ?? 0;
  }

  Future<bool> resetTimeCounter() async {
    final resp =
        await _http.httpGetJson(_EndPoints.reset) as Map<String, dynamic>;
    final String success = resp["Response"];
    return success == "reset";
  }
}
