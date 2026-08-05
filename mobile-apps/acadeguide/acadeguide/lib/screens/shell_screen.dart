import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/providers/login_provider.dart';
import 'package:acadeguide/providers/shell_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:acadeguide/routes/app_router.dart';

class ShellScreen extends ConsumerStatefulWidget {
  final Widget child;
  const ShellScreen({super.key, required this.child});

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  int selectedIndex = 0;
  double groupAlignment = -1.0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final hiddenRoutes = ["/", "/auth"];
    final hideAppbar = hiddenRoutes.contains(location);
    bool login = ref.watch(loginNotifierProvider);
    bool enable = ref.watch(shellNotifierProvider);
    print(login);
    var deviceData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: hideAppbar
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              title: SvgPicture.asset(
                'assets/images/logo.svg',
                fit: BoxFit.cover,
                height: 40,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  onPressed: () async {
                    await _authService.signOut().then((value) {
                      ref.watch(loginNotifierProvider.notifier).logout();
                      context.goNamed(AppRouter.auth.name);
                    });
                  },
                ),
              ],
            ),
      body: Row(
        children: [
          deviceData.size.width >= 500 && login && enable
              ? NavigationRail(
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                      switch (value) {
                        case 0:
                          context.goNamed(AppRouter.dashboard.name);
                        case 1:
                          context.goNamed(AppRouter.dashboard.name);
                        case 2:
                          context.goNamed(AppRouter.dashboard.name);
                        //add remaining cases here later
                      }
                    });
                  },
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard),
                      label: Text('DASHBOARD'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.search),
                      label: Text('SEARCH'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.forum),
                      label: Text('FORUMS'),
                    ),
                    //add remaining tabs here later
                  ],
                  labelType: labelType,
                  selectedIndex: selectedIndex,
                )
              : Container(),
          deviceData.size.width >= 500 ? const VerticalDivider() : Container(),
          Expanded(child: widget.child),
        ],
      ),

      bottomNavigationBar: deviceData.size.width < 500 && login && enable
          ? BottomNavigationBar(
              backgroundColor: const Color.fromARGB(255, 255, 127, 7),

              currentIndex: selectedIndex,
              selectedItemColor: const Color.fromARGB(
                255,
                255,
                255,
                250,
              ), // Color for selected item
              unselectedItemColor: Color.fromARGB(
                255,
                253,
                242,
                180,
              ), // Color for unselected items

              onTap: (value) {
                print(value);
                setState(() {
                  switch (value) {
                    case 0:
                      selectedIndex = value;
                      context.goNamed(AppRouter.dashboard.name);
                    case 1:
                      selectedIndex = value;
                      context.goNamed(AppRouter.search.name);
                    case 2:
                      selectedIndex = value;
                      context.goNamed(AppRouter.forum.name);
                  }
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'DASHBOARD',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'SEARCH',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.person),
                //   label: 'Placeholder',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.forum),
                  label: 'FORUMS',
                ),
              ],
            )
          : const SizedBox(height: 1),

      //floating action button for chatbot
    );
  }
}
