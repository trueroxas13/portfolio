import 'package:floor/floor.dart';
import 'package:quickmart/models/product.dart';

@dao
abstract class ProductDao {
  @Query("SELECT * FROM product")
  Stream<List<Product>> observeProducts();
  
  @Query("SELECT * FROM product WHERE id = :id")
  Stream<Product?> getProductById(String id);
  
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertProduct(Product product);

  @Query("SELECT * FROM product WHERE title LIKE :title AND IF (category = '', TRUE, AND category = :category)")
  Stream<List<Product>> filterProducts(String title, String category);
}