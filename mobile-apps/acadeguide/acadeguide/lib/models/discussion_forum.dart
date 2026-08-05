class Discussionforum {
  int? discussionId;
  String? userId;
  String? subject;
  String? description;
  DateTime? date_time;

  Discussionforum({
    this.discussionId,
    this.userId,
    this.subject,
    this.description,
    this.date_time,
  });

  factory Discussionforum.fromJson(Map<String, dynamic> json) {
    return Discussionforum(
      discussionId: json['id'] as int?,
      userId: json['userId'] as String?,
      subject: json['subject'] as String?,
      description: json['description'] as String?,
      date_time:
          json['date_time'] != null ? DateTime.parse(json['date_time']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'subject': subject,
      'description': description,
      'date_time': date_time?.toIso8601String(),
    };
  }
}
