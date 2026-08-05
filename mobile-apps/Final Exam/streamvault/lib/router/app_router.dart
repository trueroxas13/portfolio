import 'package:go_router/go_router.dart';
import 'package:streamvault/screens/platform_screen.dart';
import 'package:streamvault/screens/movies_screen.dart';

class AppRouter {
  // Route names and paths
  static const platformScreen = (name: 'platforms', path: '/platforms');
  static const moviesScreen =
      (name: 'movies', path: '/platforms/:platformId/movies');

  static final appRouter = GoRouter(
    initialLocation: platformScreen.path,
    routes: [
      // Platforms Screen
      GoRoute(
        name: platformScreen.name,
        path: platformScreen.path,
        builder: (context, state) => const PlatformScreen(),
        routes: [
          // Movies Screen
          GoRoute(
            name: moviesScreen.name,
            path: moviesScreen.path,
            builder: (context, state) {
              final platformId = state.pathParameters['platformId']!;
              return MoviesScreen(platformId: platformId);
            },
          ),
        ],
      ),
    ],
  );
}
