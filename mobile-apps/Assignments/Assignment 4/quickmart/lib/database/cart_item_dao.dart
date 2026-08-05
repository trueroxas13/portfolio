import 'package:floor/floor.dart';
import 'package:quickmart/models/cart_item.dart';

@dao
abstract class CartItemDao {

  @Query("SELECT * FROM cartItem")
  Stream<List<CartItem>> observeCartItems();

  @Query("SELECT * FROM cartItem WHERE productId = :productId")
  Stream<CartItem?> getCartItemById(String productId);

  @insert
  Future<void> addCartItem(CartItem cartItem);

  @update
  Future<void> updateCartItem(CartItem cartItem);

  @delete
  Future<void> deleteCartItem(CartItem cartItem);

  @Query("DELETE FROM cartItem")
  Future<void> clearCart();
}