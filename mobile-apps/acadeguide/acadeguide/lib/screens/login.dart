import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/providers/login_provider.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:acadeguide/screens/resetPassEmail.dart';
import 'package:acadeguide/screens/signup.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final AuthService _authService = AuthService();

  final Decorations _decorations = Decorations();
  String email = '';
  String password = '';
  String _errorMessage = '';
  bool _isPasswordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: Animate(
          effects: [FadeEffect(duration: Duration(seconds: 1))],
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 10,
                children: [
                  SizedBox(
                    height: 130,
                    child: SvgPicture.asset(_decorations.logo),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 80),
                          TextField(
                            controller: _emailController,
                            decoration: _decorations.fieldEntry(
                              'Email',
                              Icon(Icons.email),
                            ),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                                _errorMessage = '';
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                                _errorMessage = '';
                              });
                            },
                            obscureText: !_isPasswordVisible,
                          ),
                          const SizedBox(height: 8),
                          if (_errorMessage.isNotEmpty)
                            Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Resetpassemail(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color.fromARGB(255, 233, 140, 103),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () async {
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    _decorations.bottomPopup(
                                        "Please fill the required information!",
                                        Colors.red,
                                        Colors.white));
                                return;
                              }

                              try {
                                final value =
                                    await _authService.signIn(email, password);

                                if (value.user != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      _decorations.bottomPopup(
                                          "Login successful 🎉",
                                          Colors.green,
                                          Colors.white));

                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    ref
                                        .watch(loginNotifierProvider.notifier)
                                        .login();
                                    context.goNamed(AppRouter.dashboard.name);
                                  });
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    _decorations.bottomPopup(
                                        "Login failed, try again.",
                                        Colors.red,
                                        Colors.white));
                              }
                            },
                            style: _decorations.submitButtonStyle(),
                            child: _decorations.buttonText('L O G I N'),
                          ),
                          const SizedBox(height: 8),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Need an account?', style: TextStyle(fontSize: 15)),
                      TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Signup(),
                            ),
                          );
                        },
                        child: const Text(
                          'Register here!',
                          style: TextStyle(
                            color: Color.fromARGB(255, 233, 140, 103),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
