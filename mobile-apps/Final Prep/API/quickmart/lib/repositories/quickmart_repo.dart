import 'package:dio/dio.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';

class QmartRepo {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://quickmart.codedbyyou.com/api';
  final String _id = 'default';

  static final List<Product> _products = [];
  static bool _loaded = false;

  Future<List<Product>> getProducts() async{
    Response res = await _dio.get('$_baseUrl/products');

    if (res.statusCode != 200){
      throw Exception('Failed to fetch products');
    }

    List<Product> products = [];
    _products.clear();

    for (var productMap in res.data){
      products.add(Product.fromJSON(productMap));
      _products.add(Product.fromJSON(productMap));
    }
    _loaded = true;

    return products;
  }

  Product getProductById(String productCode) {
    if (_loaded){
      return _products.firstWhere((p) => p.id == productCode);
    } else {
      throw Exception('Products have not been loaded yet.');
    }
  }

  Future<List<String>> getFavorites() async{
    Response res = await _dio.get('$_baseUrl/favorites');

    if (res.statusCode != 200){
      throw Exception('Failed to fetch favorites');
    }

    List<String> favorites = [];

    for (var favoriteMap in res.data){
      favorites.add(favoriteMap['productId'] as String);
    }

    return favorites;
  }

  Future<bool> addFavorite(String productCode) async {
    Response res = await _dio.post('$_baseUrl/favorites', data: {'productId' : productCode, 'userId' : "default"});

    if (res.statusCode == 201){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeFavorite(String productCode) async {
    //the query parameter is due to the implementation of the api, the id refers to the favorite of a specific user
    //since we are fetching the default data, the favorite id is default
    Response res = await _dio.delete('$_baseUrl/favorites/$productCode', queryParameters: { 'favoriteId' : _id });

    if (res.statusCode == 204){
      return true;
    } else {
      return false;
    }
  }

  Future<List<String>> getCategories() async{
    Response res = await _dio.get('$_baseUrl/categories');

    if (res.statusCode != 200){
      throw Exception('Failed to fetch categories');
    }

    List<String> categories = [];

    for (var category in res.data){
      categories.add(category.toString());
    }

    return categories;
  }

  Future<List<CartItem>> getCartItems() async {
    Response res = await _dio.get('$_baseUrl/cart', queryParameters: {'fillInProducts' : 'false', 'cartId' : _id});

    if (res.statusCode != 200){
      throw Exception('Failed to fetch cart items.');
    }
    List<CartItem> items = [];

    for (var itemMap in res.data){
      Product temp = getProductById(itemMap['productId']);
      items.add(
        CartItem(productId: itemMap['productId'], quantity: itemMap['quantity'], productName: temp.title, unitPrice: temp.price)
      );
    }
    return items;    
  }

  Future<bool> addCartItem(Product p, int quantity) async {
    Response res = await _dio.post('$_baseUrl/cart', data: { 'productId' : p.id , 'quantity' : quantity }, queryParameters: { 'cartId' : _id });
  
    if (res.statusCode == 201){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyQuantity(String productCode, bool increment) async {
    Response res = await _dio.get('$_baseUrl/cart/$productCode', queryParameters: { 'cartId' : _id });

    if (res.statusCode != 200){
      throw Exception('Failed to fetch required cart item.');
    }
    if (increment){
      return await updateCartItem(productCode, res.data['quantity'] + 1);
    } else {
      return await updateCartItem(productCode, res.data['quantity'] - 1);
    }
  }

  Future<bool> removeCartItem(String productCode) async {
    Response res = await _dio.delete('$_baseUrl/cart/$productCode', queryParameters: { 'cartId' : _id });

    if (res.statusCode == 204){
      return true;
    } else {
      return false;
    }
  }
  
  Future<bool> updateCartItem(String productCode, int quantity) async {
    Response res = await _dio.put('$_baseUrl/cart/$productCode', data: { 'productId' : productCode , 'quantity' : quantity }, queryParameters: { 'cartId' : _id });
    
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Product>> filterProducts(String title, String category) async{
    if (category == "" && title == ""){
      return _products;
    }

    final Map<String, dynamic> params = {
      'name' : title,
      'category' : category,
    }..removeWhere((key, value) => value == "" );

    Response res = await _dio.get('$_baseUrl/products/search', queryParameters: params);

    if (res.statusCode != 200){
      throw Exception('Failed to fetch filtered products. Code : ${res.statusCode}');
    }

    List<Product> filtered = [];

    for (var productMap in res.data){
      filtered.add(Product.fromJSON(productMap));
    }

    for (Product p in filtered){
      print(p.title);
      print(p.category);
    }

    return filtered;
  }
}