import 'package:acadeguide/models/university.dart';
import 'package:floor/floor.dart';

@dao
abstract class UniversityDao {
  @Query("SELECT * FROM universities")
  Future<List<University>> observeUniversities();

  @Query("SELECT uniMajors FROM universities")
  Future<List<String>> getAllMajors();

  @insert
  Future<void> addUniversity(University university);
}
