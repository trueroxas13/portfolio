import 'package:dio/dio.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/category.dart';
import 'package:quickmart/models/favorite.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/user.dart';

class QmartRepo {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://quickmart.codedbyyou.com/api';
  final User _user = User.defaultUser();

  static final List<Product> loadedProducts = [];
  static bool _loaded = false;

  Future<List<Product>> getProducts() async{
    Response res = await _dio.get('$_baseUrl/products');

    if (res.statusCode != 200){
      throw Exception('Failed to fetch products');
    }

    List<Product> products = [];
    loadedProducts.clear();

    for (var productMap in res.data){
      products.add(Product.fromJSON(productMap));
      loadedProducts.add(Product.fromJSON(productMap));
    }
    _loaded = true;

    return products;
  }

  Product getProductById(String productCode) {
    if (_loaded){
      return loadedProducts.firstWhere((p) => p.id == productCode);
    } else {
      throw Exception('Products have not been loaded yet.');
    }
  }

  Future<List<Favorite>> getFavorites() async{
    Response res = await _dio.get('$_baseUrl/favorites');

    if (res.statusCode != 200){
      throw Exception('Failed to fetch favorites');
    }

    List<Favorite> favorites = [];

    for (var favoriteMap in res.data){
      favorites.add(
        Favorite(
          productId: favoriteMap['productId'],
          userId: favoriteMap['userId']
        )
      );
    }

    return favorites;
  }

  Future<bool> addFavorite(Favorite favorite) async {
    // print(favorite.userId);
    // print(favorite.productId);
    Response res = await _dio.post('$_baseUrl/favorites', data: {'productId' : favorite.productId, 'userId' : _user.id});

    if (res.statusCode == 201){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeFavorite(Favorite favorite) async {
    //the query parameter is due to the implementation of the api, the id refers to the favorite of a specific user
    //since we are fetching the default data, the favorite id is default
    Response res = await _dio.delete('$_baseUrl/favorites/${favorite.productId}', queryParameters: { 'favoriteId' :  _user.id});

    if (res.statusCode == 204){
      return true;
    } else {
      return false;
    }
  }

  Future<List<Category>> getCategories() async{
    Response res = await _dio.get('$_baseUrl/categories');

    if (res.statusCode != 200){
      throw Exception('Failed to fetch categories');
    }

    List<Category> categories = [];
    int id = 0;

    for (var category in res.data){
      categories.add(Category(category: category.toString(), id: ++id));
    }

    return categories;
  }

  Future<List<CartItem>> getCartItems() async {
    Response res = await _dio.get('$_baseUrl/cart', queryParameters: {'fillInProducts' : 'false', 'cartId' :  _user.id});

    if (res.statusCode != 200){
      throw Exception('Failed to fetch cart items.');
    }
    List<CartItem> items = [];

    for (var itemMap in res.data){
      Product temp = getProductById(itemMap['productId']);
      items.add(
        CartItem(productId: itemMap['productId'], quantity: itemMap['quantity'], productName: temp.title, unitPrice: temp.price, userId:  _user.id)
      );
    }
    return items;    
  }

  Future<bool> addCartItem(Product p, int quantity) async {
    Response res = await _dio.post('$_baseUrl/cart', data: { 'productId' : p.id , 'quantity' : quantity }, queryParameters: { 'cartId' :  _user.id });
  
    if (res.statusCode == 201){
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyQuantity(String productCode, bool increment) async {
    Response res = await _dio.get('$_baseUrl/cart/$productCode', queryParameters: { 'cartId' :  _user.id });

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
    Response res = await _dio.delete('$_baseUrl/cart/$productCode', queryParameters: { 'cartId' :  _user.id });

    if (res.statusCode == 204){
      return true;
    } else {
      return false;
    }
  }
  
  Future<bool> updateCartItem(String productCode, int quantity) async {
    Response res = await _dio.put('$_baseUrl/cart/$productCode', data: { 'productId' : productCode , 'quantity' : quantity }, queryParameters: { 'cartId' :  _user.id });
    
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Product>> filterProducts(String title, String category) async{
    if (category == "" && title == ""){
      return loadedProducts;
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
    return filtered;
  }
}