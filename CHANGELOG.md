## 0.1.0

- Basic receiving of new mails

## 0.1.1

- getting/resetting remaining time until mail is invalid
- various outsourcing into classes
- new functions:
  - `getRemainingTime()`
  - `resetRemainingTime()`
  - `getMessageCount()`

## 0.1.2

- starting a polling loop and access it easily with a stream
- stop polling loop 
- new functions:
  - `onMessagePoll(Duration interval)`
  - `stopMessagePolling()`
