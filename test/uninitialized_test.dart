import 'package:ten_minute_mail/ten_minute_mail.dart';
import 'package:test/test.dart';

void main() {
  group('Uninitialized', () {
    final mailing = TenMinuteMail();

    test('mails empty array', () {
      expect(mailing.getMails().isEmpty, isTrue);
      expect(mailing.getMessageCount() == 0, isTrue);
      expect(mailing.getAddress() == "", isTrue);
    });
  });
}
