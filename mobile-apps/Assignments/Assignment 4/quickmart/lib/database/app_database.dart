import 'dart:async';

import 'package:floor/floor.dart';
import 'package:quickmart/database/cart_item_dao.dart';
import 'package:quickmart/database/favorite_dao.dart';
import 'package:quickmart/database/product_dao.dart';
import 'package:quickmart/database/user_dao.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/favorite.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(
  version: 1,
  entities: [Product, Favorite, User, CartItem],
)
abstract class AppDatabase extends FloorDatabase{
  ProductDao get productDao;
  FavoriteDao get favoriteDao;
  UserDao get userDao;
  CartItemDao get cartItemDao;
}