import 'package:acadeguide/const.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //supabase setup
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhlamlnbnZoeGp3YWN6aXh6ZXNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUxMzUwNjMsImV4cCI6MjA2MDcxMTA2M30.GaqqyaeJPxHOJJlityj0e-CaSNhPndMjRr_gkYpomtc",
    url: "https://hejignvhxjwaczixzesg.supabase.co",
  );

  //Gemini setup
  Gemini.init(apiKey: GeminiApiKey); 
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      title: 'Acadeguide',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Acadeguide',
  //     theme: ThemeData(
  //       primarySwatch: Colors.orange,
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //     ),
  //     home: ResetPass()
  //   );
  // }
}
