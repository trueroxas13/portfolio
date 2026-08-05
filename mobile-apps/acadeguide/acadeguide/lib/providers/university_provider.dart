import 'dart:convert';

import 'package:acadeguide/models/major.dart' show Majors;
import 'package:acadeguide/models/university.dart';
import 'package:acadeguide/repo/repo_provider.dart';
import 'package:acadeguide/repo/appRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UniversityNotifier extends Notifier<List<University>> {
  late final Apprepo _universityRepo;
  List<University> _allUniversities = [];
  List<Majors> _allMajors = [];

  @override
  List<University> build() {
    initializeUniversities();
    return [];
  }

  void initializeUniversities() async {
    // List<University> universities = await _universityRepo.getUniversities();
    // state = universities;
    // _allUniversities = universities;

    _universityRepo = await ref.watch(appRepoProvider.future);

    List<University> universities = await _universityRepo.getUniversities();
    if (universities.isEmpty) {
      await _universityRepo.fetchUniversities();
      universities = await _universityRepo.getUniversities();
    }
    // Fetch and assign majors for each university
    // for (var university in universities) {
    //   final majors = await _universityRepo.getAllMajorsRaw();
    //   university.uniMajors = majors as String?;
    // }
    state = universities;
    _allUniversities = universities;
  }

  void searchUniversity(String name) {
    name = name.toLowerCase();
    if (name.isEmpty) {
      state = _allUniversities;
    } else {
      state = _allUniversities
          .where(
            (university) => university.uniName!.toLowerCase().contains(name),
          )
          .toList();
    }
  }

  University getUniversityById(String id) {
    return state.firstWhere((x) => x.uniID == id);
  }

  //==========================================================//
}

final universityNotifierProvider =
    NotifierProvider<UniversityNotifier, List<University>>(() {
  return UniversityNotifier();
});
