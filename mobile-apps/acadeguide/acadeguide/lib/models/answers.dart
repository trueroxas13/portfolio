class Answers {
  int? id;
  String? text;
  String? trait;

  Answers({this.id, this.text, this.trait});

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
      id: json['id'],
      text: json['text'],
      trait: json['interest'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'interest': trait,
      };
}
