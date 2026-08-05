import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/providers/shell_provider.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final Decorations _decorations = Decorations();

  @override
  void initState() {
    super.initState();
    Future.delayed(3.seconds, route);
  }

  void route() {
    ref.read(shellNotifierProvider.notifier).enable();
    AuthService().getUser()!.isNotEmpty
        ? context.goNamed(AppRouter.dashboard.name)
        : context.goNamed(AppRouter.auth.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Animate(
          effects: [FadeEffect(duration: 2.seconds)],
          child: SizedBox(
            height: 250, // reduced from 100 → 70
            width: 250, // reduced from 100 → 70
            child: SvgPicture.asset(
              _decorations.logo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
