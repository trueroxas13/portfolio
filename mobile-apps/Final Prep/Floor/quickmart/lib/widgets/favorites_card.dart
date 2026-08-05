import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/models/favorite.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/user_provider.dart';
import 'package:quickmart/routes/app_router.dart';



class FavoritesCard extends ConsumerStatefulWidget {
  final Product product;
  const FavoritesCard({super.key, required this.product});

  @override
  ConsumerState<FavoritesCard> createState() => _FavoritesCardState();
}

class _FavoritesCardState extends ConsumerState<FavoritesCard> {

  

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);

    return GestureDetector(
                onTap: () => {
                  context.pushNamed(AppRouter.details.name, pathParameters: {'productId' : widget.product.id})
                },
                child: Card(
                  color: Colors.white,
                  semanticContainer: true,
                  elevation: 5,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 90,child: Image.asset('assets/images/${widget.product.imageName}', fit: BoxFit.cover)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:8.0, left:4.0),
                                    child: SizedBox(
                                      width: 180,
                                      child: Text(widget.product.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),)),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:8.0, left:4.0),
                                      child: Text(
                                        '${widget.product.price}/unit', style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 15, color: const Color.fromARGB(255, 189, 189, 189)
                                        )
                                      ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:8.0, left:4.0),
                                      child: Text(
                                        'QR ${widget.product.price}', style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 15
                                        )
                                      ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 50),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(onPressed: () => {
                                    ref.read(favoritesNotifierProvider.notifier).removeFavorite(
                                      Favorite(
                                        userId: user.id,
                                        productId: widget.product.id
                                      )
                                    )
                                  }, icon: Icon(Icons.cancel_outlined)),
                                ),
                                SizedBox(height: 70),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
  }
}
