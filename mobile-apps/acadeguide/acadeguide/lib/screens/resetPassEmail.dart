import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/screens/otp_screen.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

class Resetpassemail extends StatefulWidget {
  const Resetpassemail({super.key});

  @override
  State<Resetpassemail> createState() => _ResetpassEmailState();
}

class _ResetpassEmailState extends State<Resetpassemail> {
  final AuthService _authService = AuthService();
  final Decorations _decorations = Decorations();
  String email = '';
  String _errorMessage = '';

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Animate(
          effects: [FadeEffect(duration: 1.seconds)],
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  child: SvgPicture.asset(_decorations.logo),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                            'R E S E T    P A S S W O R D',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          )
                          .animate(onPlay: (controller) => controller.loop())
                          .tint(color: Colors.lightBlue, duration: 10.seconds)
                          .then(delay: 1.seconds)
                          .tint(color: Colors.red, duration: 10.seconds),
                      SizedBox(height: 20),
                      Text(
                        'Enter your email below. If your email is registered in our system, you will receive an email to get you started shortly!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        decoration: _decorations.fieldEntry(
                          'Email',
                          Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 40),

                      ElevatedButton(
                        onPressed: () async {
                          var email = _emailController.text;
                          AuthService.userEmail = email;
                          setState(() {
                            email = _emailController.text;
                          });
                          if (email.isEmpty) {
                            setState(() {
                              _errorMessage = 'Please enter your email';
                            });
                            return;
                          }

                          try {
                            await _authService.sendOtp(email);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OtpScreen(),
                              ),
                            );
                          } catch (e) {
                            setState(() {
                              _errorMessage = 'Error: $e';
                            });
                          }
                        },
                        style: _decorations.submitButtonStyle(),
                        child: _decorations.buttonText('R E Q U E S T'),
                      ),
                      const SizedBox(height: 8),
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
