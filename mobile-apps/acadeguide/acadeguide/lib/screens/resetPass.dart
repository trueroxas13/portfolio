import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/screens/login.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final AuthService _authService = AuthService();
  final Decorations _decorations = Decorations();
  String _errorMessage = '';
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;

  final _newPassController = TextEditingController();
  final _newPassConfirmController = TextEditingController();

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
            children: [
              SvgPicture.asset(_decorations.logo),
              Text(
                    'R E S E T    P A S S W O R D',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  )
                  .animate(onPlay: (controller) => controller.loop())
                  .tint(color: Colors.lightBlue, duration: 10.seconds)
                  .then(delay: 1.seconds)
                  .tint(color: Colors.red, duration: 10.seconds),
              SizedBox(height: 20),
              TextField(
                controller: _newPassController,
                decoration: InputDecoration(
                  labelText: 'New Password',
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
                obscureText: !_isPasswordVisible,
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _newPassConfirmController,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
                      });
                    },
        
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: !_isPasswordConfirmVisible,
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () async {
                  final newPass = _newPassController.text;
                  final newPassConfirm = _newPassConfirmController.text;
        
                  try {
                    if (newPass == newPassConfirm) {
                      await _authService.updatePassword(newPass);
        
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    } else {
                      setState(() {
                        _errorMessage = 'Passwords do not match!';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      _errorMessage = 'Error: $e';
                    });
                  }
                },
                style: _decorations.submitButtonStyle(),
                child: _decorations.buttonText('R E S E T'),
              ),
              const SizedBox(height: 8),
              if (_errorMessage.isNotEmpty)
                Text(_errorMessage, style: const TextStyle(color: Colors.red)),
        
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
