class Mail {
  String subject;
  String sender;
  String body;
  String bodyHtml;
  String bodyPreview;
  String sentDate;

  Mail(this.subject, this.sender, this.body, this.bodyHtml, this.bodyPreview,
      this.sentDate);

  Mail.fromJson(Map<String, dynamic> json)
      : subject = json['subject'],
        sender = json['sender'],
        body = json['bodyPlainText'],
        bodyHtml = json['bodyHtmlContent'],
        bodyPreview = json['bodyPreview'],
        sentDate = json['sentDate'];

  @override
  String toString() {
    return 'Mail{subject: $subject, sender: $sender, body: $body, bodyHtml: $bodyHtml, bodyPreview: $bodyPreview, sentDate: $sentDate}';
  }
}
