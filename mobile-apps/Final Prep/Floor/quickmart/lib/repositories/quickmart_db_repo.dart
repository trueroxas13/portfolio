import 'package:quickmart/database/cart_item_dao.dart';
import 'package:quickmart/database/category_dao.dart';
import 'package:quickmart/database/favorite_dao.dart';
import 'package:quickmart/database/product_dao.dart';
import 'package:quickmart/database/user_dao.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/category.dart';
import 'package:quickmart/models/favorite.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';

class QmartDBRepo {
  final ProductDao productDao;
  final CartItemDao cartItemDao;
  final FavoriteDao favoriteDao;
  final CategoryDao categoryDao;
  final UserDao userDao;

  QmartDBRepo ({
    required this.productDao,
    required this.cartItemDao,
    required this.favoriteDao,
    required this.categoryDao,
    required this.userDao
  });

  Stream<List<Product>> observeProducts() => productDao.observeProducts();
  Stream<Product?> getProductById(String id) => productDao.getProductById(id);
  Future<void> upsertProduct(Product product) => productDao.upsertProduct(product); 
  Stream<List<Product>> filterProducts (String title, String category) => productDao.filterProducts(title, category);

  Stream<List<CartItem>> observeCartItems(String userId) => cartItemDao.observeItems(userId);
  Future<void> addCartItem(CartItem item) => cartItemDao.addCartItem(item);
  Future<void> removeCartItem(CartItem item) => cartItemDao.removeCartItem(item);
  Future<void> upsertCartItem(CartItem item) => cartItemDao.upsertCartItem(item);

  Stream<List<Favorite>> observeFavorites() => favoriteDao.observeFavorites();
  Stream<List<Favorite>> getUserFavorites(String userId) => favoriteDao.getUserFavorites(userId);
  Future<void> addFavorite(Favorite favorite) => favoriteDao.addFavorite(favorite);
  Future<void> removeFavorite(Favorite favorite) => favoriteDao.removeFavorite(favorite);

  Stream<List<Category>> observeCategories() => categoryDao.observeCategories();
  Future<void> upsetCategory(Category category) => categoryDao.upsertCategory(category);
  Future<void> removeCategory(Category category) => categoryDao.removeCategory(category);

  Stream<User?> getUser(String id) => userDao.getUser(id);
  Future<void> addUser(User user) => userDao.addUser(user);
  Future<void> removeUser(User user) => userDao.removeUser(user);

}