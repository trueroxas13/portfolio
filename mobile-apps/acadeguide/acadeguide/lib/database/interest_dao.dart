import 'package:acadeguide/models/interests.dart';
import 'package:floor/floor.dart';

@dao
abstract class InterestDao {
  
  @Query("SELECT * FROM interests")
  Future<List<Interests>> observeInterests();

  @insert
  Future<int> addInterest(Interests interest);
}
