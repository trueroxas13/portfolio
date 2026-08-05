import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/database/app_database.dart';
import 'package:quickmart/repositories/quickmart_db_repo.dart';

final qmartRepoProvider = FutureProvider<QmartDBRepo>((ref) async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  return QmartDBRepo(
    productDao: database.productDao, 
    cartItemDao: database.cartItemDao, 
    favoriteDao: database.favoriteDao, 
    categoryDao: database.categoryDao, 
    userDao: database.userDao
  );
});
