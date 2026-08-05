import 'package:acadeguide/models/answers.dart';

class Questions {
  int? id;
  String? questionText;
  List<Answers>? answers;

  Questions({this.id, this.questionText, this.answers});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionText = json['questionText'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'answers': answers?.map((v) => v.toJson()).toList(),
    };
  }
}
