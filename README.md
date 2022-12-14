# ten_minute_mail

A Dart library for the 10MinuteMail api.
See on [pub.dev](https://pub.dev/packages/ten_minute_mail).

## Basic usage
### Manual polling
```dart
final mailing = TenMinuteMail();
// init lib and receive mail address
await mailing.init();
print('Your address: ${mailing.getAddress()}');

while (mailing.getRemainingTime() > 0) {
  // fetch if there are new mails in inbox
  await mailing.fetchMails();
  // print current mail index
  print('Your inbox cnt: ${mailing.getMessageCount()}');
  print('Your inbox: ${mailing.getMails().toString()}');
  print('Remaining time: ${mailing.getRemainingTime().toString()}');
  await Future.delayed(Duration(seconds: 5));
  // if remaining time too low request more time
  if (mailing.getRemainingTime() < 500) {
    print("requesting more time");
    await mailing.resetRemainingTime();
  }
}
```
### Stream polling

```dart
final mailing = TenMinuteMail();
await mailing.init();
print('Your address: ${mailing.getAddress()}');

// start polling
final msgStr = mailing.onMessagePoll(Duration(seconds: 10));
msgStr.listen((mail) {
    print("new mail received");
    print(mail);
});

await Future.delayed(Duration(minutes: 1));
// stop polling
mailing.stopMessagePolling();
```

## License
Copyright 2022 Lukas Heiligenbrunner

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

