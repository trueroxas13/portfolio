import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/repositories/quickmart_repo.dart';

class ProductNotifier extends Notifier <List<Product>>{
  final QmartRepo _repo = QmartRepo();
  @override
  build() {
    initializeProducts();
    return [];
  }

  void initializeProducts() async {
    state = await _repo.getProducts();
  }

  Product getProductById (String productCode) {
    return _repo.getProductById(productCode);
  }

  Future<List<Product>> filterProducts (String title, String category) async{
    category == "None" ? category = "" : {};
    return await _repo.filterProducts(title, category);
  }
}

final productNotifierProvider 
  = NotifierProvider<ProductNotifier, List<Product>>(() => ProductNotifier()); 
