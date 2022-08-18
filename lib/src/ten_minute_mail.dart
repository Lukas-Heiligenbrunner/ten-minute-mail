import 'package:ten_minute_mail/src/api.dart';

import 'mail.dart';

class TenMinuteMail {
  List<Mail> _messages = [];
  int _msgCount = 0;
  String _address = "";
  Api _api = Api();
  int _remainingTime = 0;

  /// initalize service and receive new mail address
  Future init() async {
    _api = Api();
    _messages = [];
    _msgCount = 0;

    _address = await _api.fetchAddress();
    await _setRemainingTime();
  }

  /// get all buffered messages
  List<Mail> getMails() {
    return _messages;
  }

  /// get current email address
  String getAddress() {
    return _address;
  }

  /// get number of messages
  int getMessageCount() {
    return _msgCount;
  }

  /// get remaining time in seconds until address is invalid
  int getRemainingTime() {
    final int timeNow = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return _remainingTime - timeNow;
  }

  Future resetRemainingTime() async {
    await _api.resetTimeCounter();
    await _setRemainingTime();
  }

  /// fetch new mails available from server
  Future<List<Mail>> fetchMails() async {
    final newMsgs = await _api.fetchNewMails(_msgCount);
    _messages.addAll(newMsgs);
    _msgCount += newMsgs.length;
    return _messages;
  }

  Future _setRemainingTime() async {
    final remainingSecs = await _api.fetchRemainingTime();
    final int timeNow = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    _remainingTime = timeNow + remainingSecs;
  }
}
