//This class always listens to Auth state changes
// Redirects the user if he loggs in or out
import 'package:acadeguide/screens/dashboard.dart';
import 'package:acadeguide/screens/login.dart';
import 'package:acadeguide/screens/shell_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        //loading screen
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;
        //logged in
        if (session != null) {
          debugPrint("User is logged in");
          return ShellScreen(child: Dashboard());
        } else {
          debugPrint("User is logged out");
          return const Login();
        }
      },
    );
  }
}
