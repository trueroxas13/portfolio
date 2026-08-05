import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/repositories/quickmart_repo.dart';

class CategoriesNotifier extends Notifier <List<String>>{
  final QmartRepo _repo = QmartRepo();
  @override
  List<String> build() {
    initializeCategories();
    return [];
  }
  
  void initializeCategories () async {
    state = await _repo.getCategories();
  }
}

final categoriesNotifierProvider = NotifierProvider<CategoriesNotifier, List<String>>(() => CategoriesNotifier(),);