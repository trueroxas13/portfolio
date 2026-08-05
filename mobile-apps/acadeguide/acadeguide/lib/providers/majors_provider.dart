import 'package:acadeguide/models/major.dart';
import 'package:acadeguide/models/testResults.dart';
import 'package:acadeguide/providers/interest_provider.dart';
import 'package:acadeguide/providers/result_provider.dart';
import 'package:acadeguide/providers/traits_provider.dart';
import 'package:acadeguide/repo/appRepo.dart';
import 'package:acadeguide/repo/repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MajorsNotifier extends Notifier<List<Majors>> {
  late final Apprepo _majorsRepo;
  List<Majors> _allMajors = [];

  @override
  List<Majors> build() {
    initializeMajors();
    return _allMajors;
  }

  Future<void> initializeMajors() async {
    _majorsRepo = await ref.watch(appRepoProvider.future);
    List<Majors> majors = await _majorsRepo.getMajors();
    if (majors.isEmpty) {
      await _majorsRepo.fetchMajors();
      majors = await _majorsRepo.getMajors();
    }
    state = majors;
    _allMajors = majors;
  }

  Future<List<Majors>?> recommendMajors(
      List<String> input, String userID) async {
    // Fetch interests and traits data
    final allInterests = await ref.watch(interestNotifierProvider.future);
    final allTraits = await ref.watch(traitsNotifierProvider.future);
    List<Majors> result = [];

    // Build interest map from the Interests model
    Map<String, List<String>> interestMap = {};
    if (allInterests.isNotEmpty) {
      final interest = allInterests.first;
      if (interest.realistic != null) {
        interestMap["Realistic"] = interest.realistic!;
      }
      if (interest.investigative != null) {
        interestMap["Investigative"] = interest.investigative!;
      }
      if (interest.artistic != null) {
        interestMap["Artistic"] = interest.artistic!;
      }
      if (interest.social != null) interestMap["Social"] = interest.social!;
      if (interest.enterprising != null) {
        interestMap["Enterprising"] = interest.enterprising!;
      }
      if (interest.conventional != null) {
        interestMap["Conventional"] = interest.conventional!;
      }
    }

    // Build traits map from the Traits model
    Map<String, List<String>> traitsMap = {};
    if (allTraits.isNotEmpty) {
      final trait = allTraits.first;
      if (trait.conscientiousness != null) {
        traitsMap["Conscientiousness"] = trait.conscientiousness!;
      }
      if (trait.agreeableness != null) {
        traitsMap["Agreeableness"] = trait.agreeableness!;
      }
      if (trait.emotionalStability != null) {
        traitsMap["Emotional Stability"] = trait.emotionalStability!;
      }
      if (trait.extraversion != null) {
        traitsMap["Extraversion"] = trait.extraversion!;
      }
      if (trait.opennessToExperience != null) {
        traitsMap["Openness to Experience"] = trait.opennessToExperience!;
      }
    }

    // Scoring parameters
    const int interestWeight = 2;
    const int traitWeight = 1;
    const int threshold = 2; // minimum score for a meaningful match

    // Calculate scores for all majors
    Map<Majors, double> majorScores = {};

    for (var major in _allMajors) {
      double score = 0;
      int totalPossible = 0;

      // Match interests
      if (major.interests != null && major.interests!.isNotEmpty) {
        for (var interestCategory in major.interests!) {
          if (interestMap.containsKey(interestCategory)) {
            totalPossible +=
                interestMap[interestCategory]!.length * interestWeight;
            for (var item in interestMap[interestCategory]!) {
              if (input.contains(item)) {
                score += interestWeight;
              }
            }
          }
        }
      }

      // Match traits
      if (major.personalityTraits != null &&
          major.personalityTraits!.isNotEmpty) {
        for (var traitCategory in major.personalityTraits!) {
          if (traitsMap.containsKey(traitCategory)) {
            totalPossible += traitsMap[traitCategory]!.length * traitWeight;
            for (var item in traitsMap[traitCategory]!) {
              if (input.contains(item)) {
                score += traitWeight;
              }
            }
          }
        }
      }

      // Normalize score
      if (totalPossible > 0) {
        score = (score / totalPossible) * 100; // percentage-based normalization
      }

      majorScores[major] = score;
    }

    // Sort majors by score (highest first)
    var sortedMajors = majorScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Filter majors with meaningful match
    List<Majors> recommendedMajors = [];
    for (var entry in sortedMajors) {
      if (entry.value >= threshold) {
        recommendedMajors.add(entry.key);
      }
    }

    print('Recommended majors count: ${recommendedMajors.length}');
    if (recommendedMajors.isNotEmpty) {
      print('Top 3 recommendations:');
      for (var i = 0; i < recommendedMajors.length && i < 3; i++) {
        final major = recommendedMajors[i];
        final score = majorScores[major]!.toStringAsFixed(2);
        result.add(major);
        print('  ${i + 1}. ${major.majorName} (Score: $score%)');
      }
    }

    // Save results
    ref.read(resultNotifierProvider.notifier).addResult(Testresults(
        userId: userID, recommendedMajors: result, date_time: DateTime.now()));

    return result;
  }
}

final majorsProvider = NotifierProvider<MajorsNotifier, List<Majors>>(() {
  return MajorsNotifier();
});
