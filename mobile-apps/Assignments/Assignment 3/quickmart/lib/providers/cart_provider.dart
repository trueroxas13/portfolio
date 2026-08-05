import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/repositories/quickmart_repo.dart';

class CartNotifier extends Notifier<List<CartItem>>{
  final QmartRepo _repo = QmartRepo();
  @override
  List<CartItem> build() {
    initialize();
    return [];
  }

  void initialize() async {
    state = await _repo.getCartItems();
  }

  void increaseQuantity(String productId) async{
    bool res = await _repo.modifyQuantity(productId, true);

    if (res){
      state.firstWhere((c) => c.productId == productId).quantity += 1;
      var temp = state;
      state = [];
      state = temp;
    }
  }

  void decreaseQuantity(String productId) async{
    bool res = await _repo.modifyQuantity(productId, false);

    if (res){
      state.firstWhere((c) => c.productId == productId).quantity -= 1;
      var temp = state;
      state = [];
      state = temp;
    }
  }

  void addCartItem(Product p, int quantity) async{
    bool res = await _repo.addCartItem(p, quantity);
    print (res);
    res ? state = [...state, CartItem(productId: p.id, productName: p.title, quantity: quantity, unitPrice: p.price)] : {};
  }

  Future<bool> removeCartItem(String productId) async{
    bool res = await _repo.removeCartItem(productId);
    res ? state = state.where((c) => c.productId != productId).toList() : {};
    return res;
  }

  void updateCartItem(Product p, int quantity) async{
    bool res = await removeCartItem(p.id);
    res ? addCartItem(p, quantity) : {};
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

