import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesNotifier extends Notifier <List<String>>{
  @override
  List<String> build() {
    initializeCategories();
    return [];
  }
  
  void initializeCategories () async {
    var data = await rootBundle.loadString('assets/data/product-categories.json');

    var categoriesMap = jsonDecode(data);

    List<String> categories = [];

    categoriesMap.forEach((m) => categories.add('$m'));
    state = categories;
  }
}

final categoriesNotifierProvider = NotifierProvider<CategoriesNotifier, List<String>>(() => CategoriesNotifier(),);