import 'dart:async';

import 'package:acadeguide/database/interest_dao.dart';
import 'package:acadeguide/database/major_dao.dart';
import 'package:acadeguide/database/traits_dao.dart';
import 'package:acadeguide/database/university_dao.dart';
import 'package:acadeguide/models/interests.dart';
import 'package:acadeguide/models/list_converter.dart';
import 'package:acadeguide/models/major.dart';
import 'package:acadeguide/models/questions.dart';
import 'package:acadeguide/models/traits.dart';
import 'package:acadeguide/models/university.dart';
import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

// the generated code will be there
@Database(
    version: 1, entities: [University, Majors, Interests, Traits])
abstract class AppDatabase extends FloorDatabase {
  UniversityDao get universityDao;
  MajorDao get majorDao;
  InterestDao get interestDao;
  TraitsDao get traitsDao;
}
