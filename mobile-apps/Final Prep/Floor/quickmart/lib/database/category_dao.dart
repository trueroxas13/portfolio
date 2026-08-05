import 'package:floor/floor.dart';
import 'package:quickmart/models/category.dart';

@dao
abstract class CategoryDao {
  @Query("SELECT * FROM category")
  Stream<List<Category>> observeCategories();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertCategory(Category category);

  @delete
  Future<void> removeCategory(Category category);
}