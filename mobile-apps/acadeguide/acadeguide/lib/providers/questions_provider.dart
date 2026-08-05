import 'package:acadeguide/models/questions.dart';
import 'package:acadeguide/repo/questions_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsNotifier extends Notifier<List<Questions>> {
  final QuestionsRepo _questionsRepo = QuestionsRepo();
  List<Questions> _allQuestions = [];

  @override
  List<Questions> build() {
    initializeQuestions();
    return [];
  }

  void initializeQuestions() async {
    Stopwatch stopwatch = Stopwatch()..start();
    List<Questions> questions = await _questionsRepo.getQuestions().then((value) {
      stopwatch.stop();
      print('Time taken to fetch questions: ${stopwatch.elapsedMilliseconds} ms');
      return value;
    },);
    state = questions;
    _allQuestions = questions;
  }
}

final questionsNotifierProvider =
    NotifierProvider<QuestionsNotifier, List<Questions>>(() {
  return QuestionsNotifier();
});
