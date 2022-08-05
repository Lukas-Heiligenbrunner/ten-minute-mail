import 'package:ten_minute_mail/ten_minute_mail.dart';
import 'package:test/test.dart';

void main() {
  group('Basic', () {
    final mailing = TenMinuteMail();

    setUp(() {
      // setup code
    });

    test('mails empty array', () {
      expect(mailing.getMails().length == 0, isTrue);
      expect(mailing.getAddress() == "", isTrue);
    });

    test('receiving of new mail address', () async {
      await mailing.init();
      expect(mailing.getAddress() != "", isTrue);
    });
  });
}
