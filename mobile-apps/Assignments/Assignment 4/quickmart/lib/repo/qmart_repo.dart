import 'package:quickmart/database/cart_item_dao.dart';
import 'package:quickmart/database/favorite_dao.dart';
import 'package:quickmart/database/product_dao.dart';
import 'package:quickmart/database/user_dao.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/favorite.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';

class QmartRepo {
  final ProductDao productDao;
  final FavoriteDao favoriteDao;
  final UserDao userDao;
  final CartItemDao cartItemDao;

  QmartRepo({
    required this.productDao,
    required this.favoriteDao,
    required this.userDao,
    required this.cartItemDao,
  });

  Stream<List<Product>> observeProducts() => productDao.observeProducts();
  Stream<List<Product>> getProductsByCategory(String categoryId) => productDao.getProductsByCategory(categoryId);
  Stream<List<Product>> getProductsByTitle(String title) => productDao.getProductsByCategory(title);
  Stream<List<Product>> filterProduct(String title, String categoryId) => productDao.filterProducts(title, categoryId);
  Stream<Product?> getProductById(String id) => productDao.getProductById(id);
  Future<void> addProduct(Product product) => productDao.addProduct(product);
  
  Stream<List<User>> observeUsers() => userDao.observeUsers();
  Future<void> deleteUser(User user) => userDao.deleteUser(user);
  Future<void> updateUser(User user) => userDao.updateUser(user);
  Future<void> addUser(User user) => userDao.addUser(user);

  Stream<List<Favorite>> observeFavorites() => favoriteDao.observeFavorites();
  Future<void> addFavorite(Favorite favorite) => favoriteDao.addFavorite(favorite);
  Future<void> deleteFavorite(Favorite favorite) => favoriteDao.deleteFavorite(favorite);
  Future<Favorite?> isFavorite(String productId) => favoriteDao.isFavorite(productId);

  Stream<List<CartItem>> observeCartItems() => cartItemDao.observeCartItems();
  Stream<CartItem?> getCartItemById(String productId) => cartItemDao.getCartItemById(productId);
  Future<void> addCartItem(CartItem cartItem) => cartItemDao.addCartItem(cartItem);
  Future<void> updateCartItem(CartItem cartItem) => cartItemDao.updateCartItem(cartItem);
  Future<void> deleteCartItem(CartItem cartItem) => cartItemDao.deleteCartItem(cartItem);
  Future<void> clearCart() => cartItemDao.clearCart();
}