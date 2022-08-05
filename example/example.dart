import 'package:ten_minute_mail/src/ten_minute_mail.dart';
import 'package:ten_minute_mail/ten_minute_mail.dart';

Future<void> main() async {
  var awesome = TenMinuteMail();
  await awesome.init();
  print('Your address: ${awesome.getAddress()}');

  while (true) {
    await awesome.fetchMails();
    print('Your inbox: ${awesome.getMails().length}');
    print('Your inbox: ${awesome.getMails().toString()}');
    await Future.delayed(Duration(seconds: 5));
  }
}
