
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/providers/categories_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/widgets/product_card.dart';


class ProductScreen extends ConsumerStatefulWidget{
  const ProductScreen({super.key});
  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {

  var filteredProducts = [];
  bool hasLoaded = false;
  String dropdownVal = 'None';
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productNotifierProvider);
    final favorites = ref.watch(favoritesNotifierProvider);
    final productsCategories = ref.watch(categoriesNotifierProvider);
    
    if (!hasLoaded){
      filteredProducts = products;
      if (filteredProducts.isNotEmpty){
        hasLoaded = true;
      }
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
                    if (value == '' && dropdownVal == "None"){
                      filteredProducts = products;
                      return;
                    }
                    if (searchText.length > value.length){
                        filteredProducts = products;
                        if (dropdownVal != "None"){ 
                          filteredProducts = products.where((p) => p.category == dropdownVal).toList();
                        }
                    }
                    searchText = value;
                    filteredProducts = filteredProducts.where((p) => p.title.toLowerCase().contains(searchText.toLowerCase())).toList();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: DropdownButton<String>(
                value: dropdownVal,
                onTap: () => {
                  //getCategories()
                },
                icon: Icon(Icons.menu_rounded, color: Colors.green), 
                items: productsCategories.map((e){
                  return DropdownMenuItem(value: e, child: Text(e.toUpperCase()));
                }).toList(), 
                onChanged: (value) { 
                  setState(() {
                    dropdownVal = value!;
                    if (dropdownVal != "None"){
                      filteredProducts = products.where((p) => p.category == dropdownVal).toList();
                      if (searchText != '') {
                        filteredProducts = filteredProducts.where((p) => p.title.toLowerCase().contains(searchText.toLowerCase())).toList();
                      }
                    } else {
                      filteredProducts = products;
                      if (searchText != '') {
                        filteredProducts = filteredProducts.where((p) => p.title.toLowerCase().contains(searchText.toLowerCase())).toList();
                      }
                    }
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
              return ProductCard(product: filteredProducts[index], favorite: favorites.contains(filteredProducts[index].id));
            }),
          ),
      ),      
    );
  }
}