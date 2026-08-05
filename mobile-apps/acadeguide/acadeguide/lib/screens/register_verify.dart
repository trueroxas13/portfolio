import 'package:acadeguide/screens/login.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

class RegisterVerify extends StatefulWidget {
  const RegisterVerify({super.key});

  @override
  State<RegisterVerify> createState() => _RegisterVerifyState();
}

class _RegisterVerifyState extends State<RegisterVerify> {
  final Decorations _decorations = Decorations();
  String email = '';
  String _errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                              'R E G I S T R A T I O N',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            )
                            .animate(onPlay: (controller) => controller.loop())
                            .tint(color: Colors.lightBlue, duration: 10.seconds)
                            .then(delay: 1.seconds)
                            .tint(color: Colors.red, duration: 10.seconds),
                        SizedBox(height: 20),
                        Text(
                          'Please check your email\'s inbox within 1 hour to verify your registration.\nYou may log in once you have been verified.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 40),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            child: const Text(
                              'Return to Login',
                              style: TextStyle(
                                color: Color.fromARGB(255, 233, 140, 103),
                                fontSize: 18,
                              ),
                            ),
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
      ),
    );
  }
}
