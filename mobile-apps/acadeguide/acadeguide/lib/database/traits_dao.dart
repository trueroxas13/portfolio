import 'package:acadeguide/models/traits.dart';
import 'package:floor/floor.dart';

@dao
abstract class TraitsDao {
  @Query("SELECT * FROM traits")
  Future<List<Traits>> observeTraits();

  @insert
  Future<int> addTrait(Traits trait);
}
