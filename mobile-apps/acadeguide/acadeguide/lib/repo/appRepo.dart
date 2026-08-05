import 'dart:convert';

import 'package:acadeguide/database/interest_dao.dart';
import 'package:acadeguide/database/major_dao.dart';
import 'package:acadeguide/database/traits_dao.dart';
import 'package:acadeguide/database/university_dao.dart';
import 'package:acadeguide/models/interests.dart';
import 'package:acadeguide/models/major.dart';
import 'package:acadeguide/models/questions.dart';
import 'package:acadeguide/models/traits.dart';
import 'package:acadeguide/models/university.dart';
import 'package:flutter/services.dart';

class Apprepo {
  // // This method fetches a list of universities from a local JSON file.

  late final UniversityDao universityDao;
  late final MajorDao majorDao;
  late final InterestDao interestsDao;
  late final TraitsDao traitsDao;

  Apprepo({
    required this.universityDao,
    required this.majorDao,
    required this.interestsDao,
    required this.traitsDao,
  });

  Future<List<University>> getUniversities() =>
      universityDao.observeUniversities();

  // Future<List<String>> getAllMajorsRaw() => universityDao.getAllMajors();

  Future<List<Majors>> getMajors() => majorDao.observeMajors();

  //=================================================================//
  //Populating the database from JSON file
  Future<void> fetchUniversities() async {
    try {
      String data = await rootBundle.loadString("assets/data/university.json");
      var dataMap = jsonDecode(data);

      for (var university in dataMap) {
        await universityDao.addUniversity(University.fromJson(university));
      }
    } catch (e) {
      print("Error loading universities: $e");
    }
  }

//==========================================================================//
//Populating the database from JSON file
  Future<void> fetchMajors() async {
    try {
      String data = await rootBundle.loadString("assets/data/majors.json");
      var dataMap = jsonDecode(data);

      for (var major in dataMap) {
        await majorDao.addMajor(Majors.fromJson(major));
      }
    } catch (e) {
      print("Error loading majors: $e");
    }
  }

//==========================================================================//
  Future<List<Interests>> getInterests() => interestsDao.observeInterests();
  Future<List<Traits>> getTraits() => traitsDao.observeTraits();

  Future<void> fetchInterests() async {
    try {
      String data = await rootBundle.loadString("assets/data/interests.json");
      var dataMap = jsonDecode(data);

      for (var interest in dataMap) {
        await interestsDao.addInterest(Interests.fromJson(interest));
      }
      print("interests length: ${dataMap.length}");
      print("Interests loaded successfully");
    } catch (e) {
      print("Error loading interests: $e");
    }
  }

  Future<void> fetchTraits() async {
    try {
      String data = await rootBundle.loadString("assets/data/traits.json");
      var dataMap = jsonDecode(data);

      for (var trait in dataMap) {
        await traitsDao.addTrait(Traits.fromJson(trait));
      }
    } catch (e) {
      print("Error loading traits: $e");
    }
  }

  //==========================================================================//


}
