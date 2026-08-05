import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/models/favorite.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/user_provider.dart';
import 'package:quickmart/routes/app_router.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Product product;
  final bool favorite;
  const ProductCard({super.key, required this.product, required this.favorite});

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {  
  @override
  Widget build(BuildContext context) {
    var cartItems = ref.watch(cartNotifierProvider);
    final User user = ref.watch(userNotifierProvider);

    bool isCartItem = cartItems.where((c) => c.productId == widget.product.id).isNotEmpty;

    return GestureDetector(
                onTap: () => {
                  context.pushNamed(AppRouter.details.name, pathParameters: {'productId' : widget.product.id})
                },
                child: Card(
                  color: Colors.white,
                  semanticContainer: true,
                  elevation: 5,
                  child: Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 90, width: double.infinity,child: Image.asset('assets/images/${widget.product.imageName}', fit: BoxFit.cover)),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top:8.0, left:4.0),
                                child: Text(widget.product.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top:8.0, left:4.0),
                                child: Text(
                                  widget.product.category.toUpperCase(), style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15, color: const Color.fromARGB(255, 189, 189, 189)
                                  )
                                ),
                              )
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0, left:4.0),
                                  child: 
                                    IconButton(
                                      onPressed: (){
                                        widget.favorite ?
                                          ref.read(favoritesNotifierProvider.notifier).removeFavorite(
                                            Favorite(
                                              userId: user.id,
                                              productId: widget.product.id
                                            )
                                          ) :
                                          ref.read(favoritesNotifierProvider.notifier).addFavorite(
                                            Favorite(
                                              userId: user.id,
                                              productId: widget.product.id
                                            )
                                          );
                                      }, 
                                      icon: widget.favorite ? Icon(Icons.favorite, color: Colors.green,) : Icon(Icons.favorite_border_outlined))
                                ),
                                isCartItem ? 
                                Container(
                                  margin: const EdgeInsets.only(top:8.0, right:12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width:30, height: 30,
                                  child: Center(
                                    child: Text('${cartItems.firstWhere((c) => c.productId == widget.product.id).quantity}'
                                    , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                ) 
                                : Text('') 
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('QR ${widget.product.price}/unit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: IconButton(
                                onPressed: () => {
                                  setState(() {
                                    isCartItem ? ref.watch(cartNotifierProvider.notifier).increaseQuantity(widget.product.id) : 
                                    ref.watch(cartNotifierProvider.notifier).addCartItem(widget.product, 1);
                                  })
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 1,
                                  backgroundColor: Colors.green,
                                  minimumSize: Size(20, 20)
                                ), 
                                icon: Icon(Icons.add, color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                  ),
                ),
              );
  }
}