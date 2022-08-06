import 'package:ten_minute_mail/ten_minute_mail.dart';

Future<void> main() async {
  var mailing = TenMinuteMail();
  await mailing.init();
  print('Your address: ${mailing.getAddress()}');

  while (mailing.getRemainingTime() > 0) {
    await mailing.fetchMails();
    print('Your inbox cnt: ${mailing.getMessageCount()}');
    print('Your inbox: ${mailing.getMails().toString()}');
    print('Remaining time: ${mailing.getRemainingTime().toString()}');
    await Future.delayed(Duration(seconds: 5));
    if(mailing.getRemainingTime() < 500){
      print("resetting time");
      await mailing.resetRemainingTime();
    }
  }
}
