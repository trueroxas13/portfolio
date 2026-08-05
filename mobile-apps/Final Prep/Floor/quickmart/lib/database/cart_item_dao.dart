import 'package:floor/floor.dart';
import 'package:quickmart/models/cart_item.dart';

@dao
abstract class CartItemDao {
  @Query("SELECT * FROM cartItem WHERE userId = :userId")
  Stream<List<CartItem>> observeItems(String userId);

  @insert
  Future<void> addCartItem(CartItem item);

  @delete       
  Future<void> removeCartItem(CartItem item);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertCartItem(CartItem item);
}