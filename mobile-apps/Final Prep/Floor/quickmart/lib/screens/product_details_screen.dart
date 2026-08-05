import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/models/favorite.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/user_provider.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  String cartAddition = '1';
  String baseAddition = '-1';
  bool isFavorite = false;
  bool hasLoaded = false;
  bool isCarted = false;

  @override
  Widget build(BuildContext context) {
    final List<Favorite> favorites = ref.watch(favoritesNotifierProvider);
    final cartItems = ref.watch(cartNotifierProvider);
    final User user = ref.watch(userNotifierProvider);

    Product product = ref.watch(productNotifierProvider.notifier).getProductById(widget.productId);
    
    if (!hasLoaded && cartItems.where((c) => c.productId == widget.productId).isNotEmpty){
      cartAddition = cartItems.firstWhere((c) => c.productId == widget.productId).quantity.toString();
      baseAddition = cartAddition;
      isCarted = true;
      hasLoaded = true;
    }

    isFavorite = favorites.where((element) => element.userId == user.id && element.productId == product.id,).isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Container()
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:26.0, right:26, bottom: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.asset('assets/images/${product.imageName}', fit: BoxFit.cover,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text('QR ${product.price}  /  U N I T', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: const Color.fromARGB(255, 145, 145, 145)))),
                      SizedBox(height: 50,),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              setState(() {
                                int.parse(cartAddition) > 1 ? cartAddition = (int.parse(cartAddition) - 1).toString() 
                                : cartAddition = cartAddition;
                                
                              });
                            }, 
                            icon:int.parse(cartAddition) > 1 ? Icon(Icons.remove, color: Colors.red) : Icon(Icons.remove)
                            ),
                          Container(
                            margin: const EdgeInsets.only(top:8.0, right:12.0),
                            decoration: BoxDecoration(
                                    color: cartAddition == baseAddition ? Colors.grey :Colors.green,
                                    border: Border.all(
                                      color: cartAddition == baseAddition ? Colors.grey :Colors.green,
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                            width:45, height: 45,
                            child: Center(child: Text(cartAddition, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),))),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                cartAddition = (int.parse(cartAddition) + 1).toString();
                              });
                            }, 
                            icon: Icon(Icons.add, color: Colors.green)
                            ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: (){
                          isFavorite ? 
                            ref.read(favoritesNotifierProvider.notifier).removeFavorite(
                              Favorite(
                                userId: user.id,
                                productId: product.id
                              )
                            ) : 
                            ref.read(favoritesNotifierProvider.notifier).addFavorite(
                              Favorite(
                                userId: user.id,
                                productId: product.id
                              )
                            );
                        },  
                        icon: 
                          isFavorite ? Icon(Icons.favorite, color: Colors.green,) : Icon(Icons.favorite_border_outlined)
                        ),
                      SizedBox(height: 90,),
                      SizedBox(
                        width: 100,
                        child: Text('QR ${(product.price * int.parse(cartAddition)).toStringAsFixed(2)}',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 29,
                          ),),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              Text(product.description, style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 145, 145, 145))),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Row(
                    children: List.generate(product.rating, (rating) {
                      return Icon(Icons.star, color: const Color.fromARGB(255, 255, 201, 53));
                    }),
                  ),
                ],
              ),
              ElevatedButton(onPressed: (){
                isCarted ? {
                  cartAddition == baseAddition ? {

                  } : {
                    ref.read(cartNotifierProvider.notifier).updateCartItem(product, int.parse(cartAddition))
                  },
                  
                } : ref.read(cartNotifierProvider.notifier).addCartItem(product, int.parse(cartAddition));

                cartAddition == baseAddition ? 
                {} : context.pop();
              }, style: 
                ElevatedButton.styleFrom(backgroundColor: cartAddition == baseAddition ? Colors.grey : Colors.green, elevation: 5, minimumSize: Size(double.infinity, 55)), 
              child: 
                Text(isCarted ? 'U p d a t e   C a r t' :'A d d   t o   C a r t', style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }
}