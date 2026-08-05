import 'package:floor/floor.dart';
import 'package:quickmart/models/product.dart';

@dao
abstract class ProductDao {
  @Query("SELECT * FROM product")
  Stream<List<Product>> observeProducts();

  @insert
  Future<void> addProduct(Product product);

  @Query("SELECT * FROM product WHERE category LIKE '%:category%'")
  Stream<List<Product>> getProductsByCategory(String category);

  @Query("SELECT * FROM product WHERE title LIKE '%:title%'")
  Stream<List<Product>> getProductsByTitle(String title);

  @Query("SELECT * FROM product WHERE title LIKE '%:title%' AND category LIKE '%:category%'")
  Stream<List<Product>> filterProducts(String title, String category);

  @Query("SELECT * FROM product WHERE id = :id")
  Stream<Product?> getProductById(String id);
}