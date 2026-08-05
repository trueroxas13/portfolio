import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/widgets/cart_item_card.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  var cartItems = [];
  double total = 0;

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productNotifierProvider);
    final cart = ref.watch(cartNotifierProvider);

    if (cart.isNotEmpty){
      total = cart.map((e) => e.unitPrice * e.quantity).reduce((value, element) => value + element);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:32.0),
              child: Text('C  A  R  T', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            ),
            Divider(),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: cart.isEmpty ? 550 : 250),
                shrinkWrap: true,
                children: cart.isEmpty ? [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart, size: 475, color: const Color.fromARGB(255, 206, 206, 206),),
                      Text('Looks like your cart is empty! \nGet started by adding products!', 
                      style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 206, 206, 206)), textAlign: TextAlign.center,),
                    ],
                  ),
                ] : List.generate(cart.length, (index) {
                    cartItems = cart.map((c) => products.firstWhere((p) => p.id == c.productId)).toList();
                    return CartItemCard(product: cartItems[index], cartItem: cart.firstWhere((c) => c.productId == cartItems[index].id), );
                  }),
                ),
            ),
            cart.isEmpty ? Text('') : 
            Text('T O T A L :   QR ${total.toStringAsFixed(2)}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30),),
            ElevatedButton(onPressed: (){
                //no checkout required
              }, style: 
                ElevatedButton.styleFrom(backgroundColor: cart.isEmpty ? Colors.grey : Colors.green, elevation: 5, minimumSize: Size(double.infinity, 55)), 
              child: 
                Text('C H E C K O U T', style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }
}