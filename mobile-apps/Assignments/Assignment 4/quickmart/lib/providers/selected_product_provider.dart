import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';

class SelectedProductNotifier extends Notifier<Product>{
  @override
  Product build() {
    return Product.empty();
  }

  void setProduct(Product p){
    state = p;
  }
}

final selectedProductNotifierProvider = NotifierProvider<SelectedProductNotifier, Product>(() => SelectedProductNotifier(),);