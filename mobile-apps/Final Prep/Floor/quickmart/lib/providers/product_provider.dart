import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/repo_provider.dart';
import 'package:quickmart/repositories/quickmart_db_repo.dart';
import 'package:quickmart/repositories/quickmart_repo.dart';

class ProductNotifier extends  AsyncNotifier<List<Product>>{
  final QmartRepo _repo = QmartRepo();
  late final QmartDBRepo _dbRepo;
  @override
  build() async {
    _dbRepo = await ref.watch(qmartRepoProvider.future);
    initializeProducts();
    return [];
  }

  void initializeProducts() async {
    var products = await _repo.getProducts();
    for (Product p in products){
      _dbRepo.productDao.upsertProduct(p);
    }
    _dbRepo.productDao.observeProducts().listen((products) => state = AsyncData(products));
  }

  Product getProductById (String productCode) {
    return _repo.getProductById(productCode);
  }

  void filterProducts (String title, String category) async{
    category == "None" ? category = "" : {};
    _dbRepo.productDao.filterProducts(title, category).listen((filtered) => state = AsyncData(filtered));
  }
}

final productNotifierProvider 
  = AsyncNotifierProvider<ProductNotifier, List<Product>>(() => ProductNotifier()); 
