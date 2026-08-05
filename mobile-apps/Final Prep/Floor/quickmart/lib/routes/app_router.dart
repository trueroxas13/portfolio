import 'package:go_router/go_router.dart';
import 'package:quickmart/screens/cart_screen.dart';
import 'package:quickmart/screens/favorites_screen.dart';
import 'package:quickmart/screens/product_details_screen.dart';
import 'package:quickmart/screens/product_screen.dart';
import 'package:quickmart/screens/shell_screen.dart';

class AppRouter {
  static const home = (name: 'home', path: '/');
  static const favorites = (name: 'favorites', path: '/favorites');
  static const cart = (name: 'cart', path: '/cart');
  static const details = (name: 'details', path: '/details:productId');

  static final router = GoRouter(
    initialLocation: home.path,
    routes: [
      ShellRoute(
        builder:(context, state, child) => ShellScreen(child: child,),
        routes: [
          GoRoute(
            name: home.name,
            path: home.path,
            builder: (context, state) => ProductScreen(),
            routes: [
              GoRoute(
                name: favorites.name,
                path: favorites.path,
                builder: (context, state) => FavoritesScreen()
              ),
              GoRoute(
                name: cart.name,
                path: cart.path,
                builder: (context, state) => CartScreen()
              ),
              GoRoute(
                name: details.name,
                path: details.path,
                builder: (context, state) {
                  var productId = state.pathParameters['productId']; 
                  return ProductDetailsScreen(productId: productId!);
                  }
              ),
            ]
          )
      ])
      
    ]
  );
}