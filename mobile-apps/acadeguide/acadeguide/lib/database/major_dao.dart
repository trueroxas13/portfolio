import 'package:acadeguide/models/major.dart';
import 'package:floor/floor.dart';

@dao 
abstract class MajorDao{
  @Query("SELECT * FROM majors")
  Future<List<Majors>> observeMajors();


  @insert
  Future<void> addMajor(Majors major);  
}