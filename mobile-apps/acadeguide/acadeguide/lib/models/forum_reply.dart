class Forumreply {
  int? id;
  String? userId;
  int? discussionId;
  String? reply;
  DateTime? date_time;

  Forumreply({
    this.id,
    this.userId,
    this.discussionId,
    this.reply,
    this.date_time,
  });

  factory Forumreply.fromJson(Map<String, dynamic> json) {
    return Forumreply(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      discussionId: json['discussion_id'] as int?,
      reply: json['reply'] as String?,
      date_time:
          json['date_time'] != null ? DateTime.parse(json['date_time']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'discussion_id': discussionId,
      'reply': reply,
      'date_time': date_time?.toIso8601String(),
    };
  }
}
