import 'dart:typed_data';

import 'package:acadeguide/database/app_database.dart';
import 'package:acadeguide/repo/appRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRepoProvider = FutureProvider<Apprepo>((ref) async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  return Apprepo(
      universityDao: database.universityDao,
      majorDao: database.majorDao,
      interestsDao: database.interestDao,
      traitsDao: database.traitsDao);
});
final selectedUniProvider = StateProvider<int?>((ref) => null);
