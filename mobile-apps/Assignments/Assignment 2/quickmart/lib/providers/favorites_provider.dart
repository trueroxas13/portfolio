import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends Notifier<List<String>>{
  @override
  List<String> build() {
    initializeFavorites();
    return [];
  }

  void initializeFavorites() async {
    var data = await rootBundle.loadString('assets/data/favorites.json');
    
    var keys = jsonDecode(data);

    List<String> favs = [];

    keys.forEach((k) => favs.add('$k')); 

    state = favs;
  }

  void addFavorite(String productCode) {
    state = [...state, productCode];
  }

  void removeFavorite(String productCode) {
    state = state.where((s) => s!= productCode).toList();
  }
}

final favoritesNotifierProvider = NotifierProvider<FavoritesNotifier, List<String>>(() => FavoritesNotifier());