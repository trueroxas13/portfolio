import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/screens/resetPass.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthService _authService = AuthService();
  final Decorations _decorations = Decorations();

  String _errorMessage = '';

  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 130, child: SvgPicture.asset(_decorations.logo)),
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
                      'We have sent you a code\nPlease enter it below',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),

                    // TextField(
                    //   controller: _otpController,
                    //   decoration: _decorations.fieldEntry('OTP', Icon(Icons.lock_outline))
                    // ),
                    OtpTextField(
                      numberOfFields: 6,
                      borderColor: Colors.amber,
                      focusedBorderColor: Colors.lightBlue,
                      borderWidth: 4,
                      showFieldAsBox: true,
                      onSubmit: (value) {
                        _otpController.text = value;
                      },
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () async {
                        final otp = _otpController.text;

                        try {
                          await _authService.verifyOtp(otp);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPass(),
                            ),
                          );
                        } catch (e) {
                          setState(() {
                            _errorMessage = 'Error: $e';
                          });
                        }
                      },
                      style: _decorations.submitButtonStyle(),
                      child: _decorations.buttonText('V E R I F Y'),
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
    );
  }
}
