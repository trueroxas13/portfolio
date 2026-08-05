import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/repositories/quickmart_repo.dart';

class FavoritesNotifier extends Notifier<List<String>>{
  final QmartRepo _repo = QmartRepo(); 
  @override
  List<String> build() {
    initializeFavorites();
    return [];
  }

  void initializeFavorites() async {
    state = await _repo.getFavorites();
  }

  void addFavorite(String productCode) async{
    bool res = await _repo.addFavorite(productCode);
    res ? state = [...state, productCode] : {};
  }

  void removeFavorite(String productCode) async{
    bool res = await _repo.removeFavorite(productCode);
    res ? state = state.where((s) => s!= productCode).toList() : {};
  }
}

final favoritesNotifierProvider = NotifierProvider<FavoritesNotifier, List<String>>(() => FavoritesNotifier());