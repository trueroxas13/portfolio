import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/search_filter.dart';
import 'package:quickmart/providers/repo_provider.dart';
import 'package:quickmart/repo/product_repo.dart';
import 'package:quickmart/repo/qmart_repo.dart';

class ProductProvider extends AsyncNotifier<List<Product>> {
  late final QmartRepo _repo; 
  final ProductRepo _productRepo = ProductRepo();
  @override
  Future<List<Product>> build() async{
    _repo = await ref.watch(qmartRepoProvider.future);
    initliazeProducts();
    _repo.observeProducts().listen((products) {
      state = AsyncData(products);
    }); 
    return [];
  }

  Future<void> initliazeProducts() async{
    List<Product> products = []; 
    _productRepo.loadRepo().then((products)  {
      products = products;
      for (Product p in products){
        _repo.getProductById(p.id!).listen((product) {
          product != null ? {} : _repo.addProduct(p);
        });
      }
    });
    
  }Stream<Product?> getProductById(String id) {   
    return _repo.getProductById(id);
  }

  void filterProducts(SearchFilters filters) async {
    try {
      state = const AsyncLoading(); // Notify listeners that we're loading
      List<Product> filteredProducts =  [];
      print(filters.categories[0]);
      print(filters.searchText);
      if (filters.searchText.isEmpty && filters.categories.isNotEmpty){
        _repo.getProductsByCategory(filters.categories[0]).listen((products) {
          filteredProducts = products;
          print(filteredProducts[0].title);
          state = AsyncValue.data(filteredProducts);
          return;
        });
      }

      if (filters.searchText.isNotEmpty && filters.categories.isEmpty){
        _repo.getProductsByTitle(filters.searchText).listen((products) {
          filteredProducts = products;
          print(filteredProducts[0].title);
          state = AsyncValue.data(filteredProducts);
          return;
        });
      }

      _repo.filterProduct(filters.searchText, filters.categories[0]).listen((products){
        filteredProducts = products;
        state = AsyncValue.data(filteredProducts);
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final productProviderNotifier = AsyncNotifierProvider<ProductProvider, List<Product>>(() => ProductProvider());
  