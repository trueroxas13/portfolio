import 'package:acadeguide/screens/chatbot_screen.dart';
import 'package:acadeguide/screens/create_forum.dart';
import 'package:acadeguide/screens/dashboard.dart';
import 'package:acadeguide/screens/forum_screen.dart';
import 'package:acadeguide/screens/forum_details.dart';
import 'package:acadeguide/screens/login.dart';
import 'package:acadeguide/screens/main_test_screen.dart';
import 'package:acadeguide/screens/profile_screen.dart';
import 'package:acadeguide/screens/results_screen.dart';
import 'package:acadeguide/screens/sResult_screen.dart';
import 'package:acadeguide/screens/shell_screen.dart';
import 'package:acadeguide/screens/splash_screen.dart';
import 'package:acadeguide/screens/uni_details.dart';
import 'package:acadeguide/screens/universties_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const splash = (name: 'splash', path: '/');
  static const auth = (name: 'auth', path: '/auth');
  static const dashboard = (name: 'dashboard', path: '/dashboard');
  static const profile = (name: 'profile', path: '/profile');
  static const sresult = (name: 'sresult', path: '/profile/sresult:id');
  static const test = (name: 'test', path: '/test');
  static const result = (name: 'result', path: '/test/result');
  static const search = (name: 'search', path: '/search');
  static const uniDetails = (name: 'uniDetails', path: '/search/uni:id');
  static const forum = (name: 'forums', path: '/forums');
  static const newForum = (name: 'newForum', path: '/forums/new');
  static const forumDetails = (name: 'forumDetails', path: '/forums/forum:id');
  static const chatbot = (name: 'chatbot', path: '/chatbot');
  static const forgotPassword = (
    name: 'forgotPassword',
    path: '/forgotPassword',
  );

  static final router = GoRouter(
    initialLocation: splash.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) => ShellScreen(child: child),
        routes: [
          GoRoute(
            name: splash.name,
            path: splash.path,
            builder: (context, state) => SplashScreen(),
            routes: [
              GoRoute(
                name: auth.name,
                path: auth.path,
                builder: (context, state) => Login(),
                routes: [
                  GoRoute(
                    name: dashboard.name,
                    path: dashboard.path,
                    builder: (context, state) => Dashboard(),
                    routes: [
                      GoRoute(
                          name: profile.name,
                          path: profile.path,
                          builder: (context, state) => ProfileScreen(),
                          routes: [
                            GoRoute(
                              name: sresult.name,
                              path: sresult.path,
                              builder: (context, state) {
                                String? id = state.pathParameters['id'];
                                return SResultScreen(
                                  resultId: id!,
                                );
                              },
                            )
                          ]),
                      GoRoute(
                        name: search.name,
                        path: search.path,
                        builder: (context, state) => UniverstiesScreen(),
                        routes: [
                          GoRoute(
                            name: uniDetails.name,
                            path: uniDetails.path,
                            builder: (context, state) {
                              String? id = state.pathParameters['id'];
                              return UniDetails(uniId: id!);
                            },
                          ),
                        ],
                      ),
                      GoRoute(
                        name: test.name,
                        path: test.path,
                        builder: (context, state) => MainTestScreen(),
                      ),
                      GoRoute(
                        name: result.name,
                        path: result.path,
                        builder: (context, state) {
                          return ResultScreen();
                        },
                      ),
                      GoRoute(
                          path: forum.path,
                          name: forum.name,
                          builder: (context, state) => Forumscreen(),
                          routes: [
                            GoRoute(
                              name: newForum.name,
                              path: newForum.path,
                              builder: (context, state) => CreateForumscreen(),
                            ),
                            GoRoute(
                              name: forumDetails.name,
                              path: forumDetails.path,
                              builder: (context, state) {
                                String? id = state.pathParameters['id'];
                                return ForumDetails(forumId: id!);
                              },
                            ),
                          ]),
                      GoRoute(
                          path: chatbot.path,
                          name: chatbot.name,
                          builder: (context, state) => ChatbotScreen())
                    ],
                  ),
                ],
              ),
            ],
          ),

          // add other routes here later
        ],
      ),
    ],
  );
}
