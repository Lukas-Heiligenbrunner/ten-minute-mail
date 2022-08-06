import 'package:ten_minute_mail/ten_minute_mail.dart';
import 'package:test/test.dart';

void main() {
  group('Basic', () {
    final mailing = TenMinuteMail();

    setUp(() async {
      await mailing.init();
    });

    test('receiving of new mail address', () async {
      expect(mailing.getAddress() != "", isTrue);
    });

    test('remaining time counter', () async {
      expect(mailing.getRemainingTime() > 400, isTrue);
    });
  });
}
