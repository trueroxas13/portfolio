import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/repo/qmart_repo.dart';
import '../database/app_database.dart';

final qmartRepoProvider = FutureProvider<QmartRepo>((ref) async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  return QmartRepo(
    productDao: database.productDao,
    favoriteDao: database.favoriteDao, 
    userDao: database.userDao, 
    cartItemDao: database.cartItemDao);
});

final selectedProductIdProvider = StateProvider<int?>((ref) => null);