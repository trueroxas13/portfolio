import 'dart:convert';

import 'package:acadeguide/models/testResults.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Testresultrepo {
  final db = Supabase.instance.client.from('test_result');

  //Add test result
  Future addTestResult(Testresults testResult) async {
    //works
    await db.insert({
      'userId': testResult.userId,
      'recommendedMajors': testResult.recommendedMajors != null
          ? jsonEncode(
              testResult.recommendedMajors!.map((m) => m.toJson()).toList())
          : jsonEncode([]),
      'date_time': testResult.date_time?.toIso8601String(),
    });
  }

  //Get all test results
  Future<List<Testresults>> getTestResults() {
    return Supabase.instance.client
        .from('test_result')
        .stream(primaryKey: ['id'])
        .map(
          (data) =>
              data.map<Testresults>((e) => Testresults.fromJson(e)).toList(),
        )
        .first;
  }

  Future<List<Testresults>> getUserTestResults(String userId) async {
    return await db.select().eq('userId', userId).then((data) => (data as List)
        .map<Testresults>((test) => Testresults.fromJson(test))
        .toList());
  }
}
