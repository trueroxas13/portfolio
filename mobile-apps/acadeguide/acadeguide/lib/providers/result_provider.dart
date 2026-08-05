import 'package:acadeguide/models/testResults.dart';
import 'package:acadeguide/repo/testResultRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class resultNotifier extends Notifier<List<String>> {
  final Testresultrepo _testResultRepo = Testresultrepo();

  @override
  List<String> build() {
    return [];
  }

  Future<List<Testresults>> getResults() {
    return _testResultRepo.getTestResults();
  }

  void addResult(Testresults result) async {
    await _testResultRepo.addTestResult(result);
  }

  Future<List<Testresults>> getUserResults(String userId) {
    return _testResultRepo.getUserTestResults(userId);
  }
}

final resultNotifierProvider =
    NotifierProvider<resultNotifier, List<String>>(() {
  return resultNotifier();
});
