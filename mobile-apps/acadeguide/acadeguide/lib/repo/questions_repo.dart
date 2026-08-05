import 'dart:convert';

import 'package:acadeguide/models/questions.dart';
import 'package:flutter/services.dart';

class QuestionsRepo {


  
  Future<List<Questions>> getQuestions() async {
    try {
      List<Questions> questions = [];
      String data = await rootBundle.loadString("assets/data/questions.json");
      var dataMap = jsonDecode(data);

      for (var question in dataMap) {
        questions.add(Questions.fromJson(question));
      }
      print(questions);

      return questions;
    } catch (e) {
      print("Error loading questions: $e");
      return [];
    }
  }
}
