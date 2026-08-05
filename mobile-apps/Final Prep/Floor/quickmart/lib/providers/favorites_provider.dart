import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/favorite.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/repositories/quickmart_repo.dart';

class FavoritesNotifier extends Notifier<List<Favorite>>{
  final QmartRepo _repo = QmartRepo();
  @override
  List<Favorite> build() {
    initializeFavorites();
    return [];
  }

  void initializeFavorites() async {
    state = await _repo.getFavorites();
  }

  void addFavorite(Favorite favorite) async{
    bool res = await _repo.addFavorite(favorite);
    res ? state = [...state, favorite] : {};
  }

  void removeFavorite(Favorite favorite) async{
    bool res = await _repo.removeFavorite(favorite);
    
    res ? state.removeWhere((f) => (f.productId == favorite.productId && f.userId == favorite.userId)) : {};

    reload();
  }

  List<Favorite> getUserFavorites(String userId) {
    return state.where((element) => element.userId == userId,).toList();
  }

  List<Product> getUserFavoriteProducts(String userId) {
    var products = QmartRepo.loadedProducts;
    List<Favorite> favorites = getUserFavorites(userId);

    List<Product> reqProducts = products.where((p) => favorites.contains(Favorite(productId: p.id, userId: userId))).toList();

    for (var f in favorites){
      reqProducts.add(products.firstWhere((p) => p.id == f.productId));
    }

    return reqProducts;
  }

  void reload (){
    var temp = state;
    state = [];
    state = temp;
  }
}

final favoritesNotifierProvider = NotifierProvider<FavoritesNotifier, List<Favorite>>(() => FavoritesNotifier());