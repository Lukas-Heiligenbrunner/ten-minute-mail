import 'package:ten_minute_mail/src/api.dart';

import 'mail.dart';

class TenMinuteMail {
  List<Mail> _messages = [];
  int _msgCount = 0;
  late String _address = "";
  Api _api = Api();

  Future init() async {
    _api = Api();
    _messages = [];
    _msgCount = 0;

    _address = await _api.fetchAddress();
  }

  List<Mail> getMails() {
    return _messages;
  }

  String getAddress() {
    return _address;
  }

  int getMessageCount() {
    return _msgCount;
  }

  Future<List<Mail>> fetchMails() async {
    var newMsgs = await _api.fetchNewMails(_msgCount);
    _messages.addAll(newMsgs);
    _msgCount += newMsgs.length;
    return _messages;
  }
}
