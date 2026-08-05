import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MoviePalApp(),
    ),
  );
}

class MoviePalApp extends StatelessWidget {
  const MoviePalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MoviePal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: AppRouter.appRouter,
    );
  }
}
