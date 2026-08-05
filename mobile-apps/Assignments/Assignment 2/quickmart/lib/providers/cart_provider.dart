import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';

class CartNotifier extends Notifier<List<CartItem>>{
  @override
  List<CartItem> build() {
    return [];
  }

  void increaseQuantity(String productId){
    state.firstWhere((c) => c.productId == productId).quantity += 1;
    var temp = state;
    state = [];
    state = temp;
  }

  void decreaseQuantity(String productId){
    state.firstWhere((c) => c.productId == productId).quantity -= 1;
    var temp = state;
    state = [];
    state = temp;
  }

  void addCartItem(Product p, int quantity){
    state = [...state, CartItem(productId: p.id, productName: p.title, quantity: quantity, unitPrice: p.price)];
  }

  void removeCartItem(String productId){
    state = state.where((c) => c.productId != productId).toList();
  }

  void updateCartItem(Product p, int quantity){
    removeCartItem(p.id);
    addCartItem(p, quantity);
  }

  void addAllToCart(List <Product> products){
    for (var p in products) {
      if (state.where((c) => c.productId == p.id).isNotEmpty){
        increaseQuantity(p.id);
      } else {
        addCartItem(p, 1);
      }
    }
  }
}

final cartNotifierProvider = NotifierProvider<CartNotifier, List<CartItem>>(() => CartNotifier(),);

