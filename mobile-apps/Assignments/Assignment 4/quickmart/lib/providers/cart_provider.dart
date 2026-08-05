import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/cart.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/repo_provider.dart';
import 'package:quickmart/repo/qmart_repo.dart';


// Everywhere in here, i am updating the state of the cart to reflect the changes in the cart items visually first before updating the database.
// This is because if we update the databse and show the loading spinner, the user might think the app is slow or not responding.
// So, we update the state first and then update the database. If the database update fails, we can revert the state back to the previous state
// Or fetch the cart items from the database again to reflect the changes in the cart items like it rolled back.
// This is a good practice to follow in your app to make it more responsive and user friendly.
class CartProvider extends AsyncNotifier<Cart> {
  //final CartRepository _cartRepo;
  late final QmartRepo _repo;
  List<CartItem> items = [];

  // Constructor to initialize the repository
  //CartProvider(this._cartRepo);

  // Load cart items asynchronously
  @override
  Future<Cart> build() async {
    _repo = await ref.watch(qmartRepoProvider.future);
    try {
      _repo.observeCartItems().map((products) {
        products.isNotEmpty ? items = products : {};
      });
      
      return Cart(items);
    } catch (e) {
      print(e);
      return Cart([]);
    }
  }

  // Add a product to the cart asynchronously and refresh the state
  Future<void> addProductToCart(Product product, {int quantity = 1}) async { 
    try {
      final cart = state.maybeWhen(data: (cart) => cart, orElse: () => Cart([]));
      final items = cart.items;
      final CartItem cartItem;
      final index = items.indexWhere((item) => item.productId == product.id);
      if (index == -1) {
        cartItem = CartItem(
            productId: product.id!,
            userId: product.id!,
            title: product.title,
            unitPrice: product.price,
            imageUrl: product.imageName,
            category: product.category,
            description: product.description,
            quantity: quantity,
          );
        items.add(
          cartItem
        );
         await _repo.addCartItem(cartItem);
      } else {
        items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
        cartItem = items[index];
        cartItem.quantity += 1;
        
        await _repo.updateCartItem(cartItem);
      }
      state = AsyncValue.data(Cart(items));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); 
    }
  }

  Future<void> removeProductFromCart(Product product) async {
    // state = const AsyncValue.loading(); 
    try { 
      final cart = state.asData?.value;
      final items = cart?.items ?? [];
      final index = items.indexWhere((item) => item.productId == product.id);
      final CartItem cartItem = items[index];
      final quantity = items[index].quantity;
      if (quantity > 1) {
        cartItem.quantity -= 1;
        await _repo.updateCartItem(cartItem);
        items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
      } else {
        items.removeAt(index);
        await _repo.deleteCartItem(cartItem);
      }
      state = AsyncValue.data(Cart(items));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> clearCart() async {
    state = const AsyncValue.loading(); 
    try {
      await _repo.clearCart();
      // Simulating a delay to show the loading spinner for a fast loading process
      await Future.delayed(const Duration(milliseconds: 800));
      state = AsyncValue.data(Cart([])); 
    } catch (e) {
      state = AsyncValue.error(e , StackTrace.current);
    }
  }

  // Get the total price from the cart items
  double getTotalPrice() {
    return state.maybeWhen(data: (cart) => cart.getTotalPrice(), orElse: () => 0.0);
  }

  int getProductQuantity(String productId) {
    return state.maybeWhen(data: (cart) => cart.getQuantity(productId), orElse: () => 0);
  }

  // Add all products to the cart asynchronously
  Future<void> addAllProductsToCart(List<Product> products) async {
    try {
      final cartItems = state.maybeWhen(data: (cart) => cart.items, orElse: () => <CartItem>[]);
      for (var product in products) {
        final cartItemIndex = cartItems.indexWhere((item) => item.id == product.id);
        final currentQuantity = cartItemIndex == -1 ? 0 : cartItems[cartItemIndex].quantity;
        final CartItem cartItem;
        if (cartItemIndex == -1) {
          cartItem = CartItem(
              productId: product.id!,
              userId: product.id!,
              title: product.title,
              unitPrice: product.price,
              imageUrl: product.imageName,
              category: product.category,
              description: product.description,
              quantity: 1,
            );
          cartItems.add(
            cartItem
          );
        } else {
          cartItem = cartItems[cartItemIndex];
          cartItem.quantity += 1;
          cartItems[cartItemIndex] = cartItems[cartItemIndex].copyWith(quantity: currentQuantity + 1);
        }

        await _repo.addCartItem(cartItem);
      }
      state = AsyncValue.data(Cart(cartItems));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

}

final cartProviderNotifier = AsyncNotifierProvider<CartProvider, Cart>(() => CartProvider());
