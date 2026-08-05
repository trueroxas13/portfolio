import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';

class ProductNotifier extends Notifier <List<Product>>{
  @override
  build() {
    initializeProducts();
    return [];
  }

  void initializeProducts() async {
    String data = await rootBundle.loadString('assets/data/products.json');

    var map = jsonDecode(data);

    List<Product> products = [];
    map.forEach((m) => products.add(Product.fromJSON(m)));
    state = products;
  }
}

final productNotifierProvider 
  = NotifierProvider<ProductNotifier, List<Product>>(() => ProductNotifier()); 
