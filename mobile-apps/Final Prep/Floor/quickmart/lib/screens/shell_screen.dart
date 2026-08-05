import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/routes/app_router.dart';

class ShellScreen extends ConsumerStatefulWidget {
  final Widget? child;
  const ShellScreen({super.key, this.child});

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value){
          setState(() {
          switch(value){
            case 0:
              selectedIndex = value;
              context.goNamed(AppRouter.home.name);
            case 1:
              selectedIndex = value;
              context.goNamed(AppRouter.cart.name);
            case 2:
              selectedIndex = value;
              context.goNamed(AppRouter.favorites.name);
          }
        });
        },
        items: [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.store_mall_directory_outlined, color: Colors.green,),
          icon: Icon(Icons.store_mall_directory_outlined), label: 'Store'),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.shopping_cart, color: Colors.green,),
          icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.favorite, color: Colors.green),
          icon: Icon(Icons.favorite_border_outlined), label: 'Favorites'),
        ]
      ),
    );
  }
}