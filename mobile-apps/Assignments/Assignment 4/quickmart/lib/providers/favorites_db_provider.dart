import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/favorite.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/repo_provider.dart';
import 'package:quickmart/repo/qmart_repo.dart';

/// A provider that manages the favorite products asynchronously
class FavoriteNotifier extends AsyncNotifier<List<Favorite>> {
  late final QmartRepo _repo;


  @override
  Future<List<Favorite>> build() async {
    _repo = await ref.watch(qmartRepoProvider.future);
    _loadFavorites();
    return [];
  }

  _loadFavorites() {
    try {
      _repo.observeFavorites().listen((favorites) {
        state = AsyncValue.data(favorites);
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); 
    }
  }

  addFavorite(Product p){
    final List<Favorite> favorites = state.maybeWhen(data: (favs) => favs, orElse: () => []);
    Favorite fav = Favorite(productId: p.id!, userId: 'userId');
    try {
      favorites.add(fav);
      state = AsyncValue.data(favorites);
    } catch (e){
      state = AsyncValue.error(e, StackTrace.current); 
    }
    _repo.addFavorite(
      fav
    );
  }

  removeFavorite(Product p){
    final List<Favorite> favorites = state.maybeWhen(data: (favs) => favs, orElse: () => []);
    Favorite fav = Favorite(productId: p.id!, userId: 'userId');
    try {
      favorites.removeWhere((f) => f.productId == p.id);
      state = AsyncValue.data(favorites);
    } catch (e){
      state = AsyncValue.error(e, StackTrace.current); 
    }
    _repo.deleteFavorite(
      fav
    );
  }

  bool isFavorite(Product p){
    final List<Favorite> favorites = state.maybeWhen(data: (favs) => favs, orElse: () => []);
    if(favorites.where((f) => f.productId == p.id).isNotEmpty){
      return true;
    } else {
      return false;
    }
  }

  List<Product> getFavoriteProducts() {
    final List<Favorite> favorites = state.maybeWhen(data: (favs) => favs, orElse: () => []);
    List<Product> products = [];
    for (var f in favorites){
      _repo.getProductById(f.productId).listen((data){
        products.add(data!);
      });
    }
    return products;
  }
}

final favoriteProviderNotifier = AsyncNotifierProvider<FavoriteNotifier, List<Favorite>>(
  () => FavoriteNotifier(),
);
