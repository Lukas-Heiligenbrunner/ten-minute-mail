import 'package:ten_minute_mail/ten_minute_mail.dart';

Future<void> main() async {
  final mailing = TenMinuteMail();
  await mailing.init();
  print('Your address: ${mailing.getAddress()}');

  final str = mailing.onMessagePoll(Duration(seconds: 10));
  str.listen((mail) {
    print("new mail received");
    print(mail);
  });

  await Future.delayed(Duration(minutes: 1));
  mailing.stopMessagePolling();
}
