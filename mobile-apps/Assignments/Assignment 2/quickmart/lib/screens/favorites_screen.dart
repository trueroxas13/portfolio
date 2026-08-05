import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/widgets/favorites_card.dart';


class FavoritesScreen extends ConsumerStatefulWidget{
  const FavoritesScreen({super.key});
  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {

  List<Product> favoriteProducts = [];

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productNotifierProvider);
    final favorites = ref.watch(favoritesNotifierProvider);
    
    favoriteProducts = products.where((p) => favorites.contains(p.id)).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:32.0),
              child: Text('F A V O R I T E S', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            ),
            Divider(),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: favorites.isEmpty ? 600 : 200),
                children: favoriteProducts.isEmpty ? [
                  Column(
                    children: [
                      Icon(Icons.favorite, size: 425, color: const Color.fromARGB(255, 206, 206, 206),),
                      Text('Looks like you don\'t have any favorites! \nGet started by favoriting products!', 
                        style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 206, 206, 206)), textAlign: TextAlign.center,),
                    ],
                  ),
                ] : List.generate(favoriteProducts.length, (index) {
                    return FavoritesCard(product: favoriteProducts[index]);
                  }),
                ),
            ),
              ElevatedButton(onPressed: (){
                ref.read(cartNotifierProvider.notifier).addAllToCart(favoriteProducts);
              }, style: 
                ElevatedButton.styleFrom(backgroundColor: favoriteProducts.isEmpty ? Colors.grey : Colors.green, elevation: 5, minimumSize: Size(double.infinity, 55)), 
              child: 
                Text('A D D   A L L   T O   C A R T', style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }
}