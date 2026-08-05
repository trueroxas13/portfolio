import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';
import 'package:quickmart/providers/categories_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/update_provider.dart';
import 'package:quickmart/providers/user_provider.dart';
import 'package:quickmart/widgets/product_card.dart';


class ProductScreen extends ConsumerStatefulWidget{
  const ProductScreen({super.key});
  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {

  List<Product> filteredProducts = [];
  bool hasLoaded = false;
  String dropdownVal = 'None';
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesNotifierProvider);
    final productsCategories = ref.watch(categoriesNotifierProvider);
    final User user = ref.watch(userNotifierProvider);
    
    //initial load
    if (!hasLoaded){
      filteredProducts = ref.watch(productNotifierProvider);
      if (filteredProducts.isNotEmpty){
        hasLoaded = true;
      }
    }

    //reload to reflect changes
    if (ref.watch(updateNotifierProvider)){
      filteredProducts = ref.watch(productNotifierProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'S E A R C H',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value){
                  setState(() {
                    searchText = value;
                    ref.read(productNotifierProvider.notifier).filterProducts(searchText, dropdownVal);
                    ref.read(updateNotifierProvider.notifier).startUpdate();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: DropdownButton<String>(
                value: dropdownVal,
                icon: Icon(Icons.menu_rounded, color: Colors.green), 
                items: [
                  DropdownMenuItem(value: 'None',child: Text('NONE')),
                  ... productsCategories.map((e){
                  return DropdownMenuItem(value: e.category, child: Text(e.category.toUpperCase()));
                }), 
                ],
                onChanged: (value) { 
                  setState(() {
                    dropdownVal = value!;
                    ref.read(productNotifierProvider.notifier).filterProducts(searchText, dropdownVal);
                    ref.read(updateNotifierProvider.notifier).startUpdate();
                  });
                 },
                ),
            ),
          ],
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 13, crossAxisSpacing: 13, mainAxisExtent: 362),
          children: List.generate(filteredProducts.length, (index) {
              return ProductCard(product: filteredProducts[index], 
                favorite: favorites.where((element) => element.userId == user.id && element.productId == filteredProducts[index].id,).isNotEmpty);
            }),
          ),
      ),      
    );
  }
}