import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/category.dart';
import 'package:quickmart/repositories/quickmart_repo.dart';

class CategoriesNotifier extends Notifier <List<Category>>{
  final QmartRepo _repo = QmartRepo();
  @override
  List<Category> build() {
    initializeCategories();
    return [];
  }
  
  void initializeCategories () async {
    state = await _repo.getCategories();
  }
}

final categoriesNotifierProvider = NotifierProvider<CategoriesNotifier, List<Category>>(() => CategoriesNotifier(),);