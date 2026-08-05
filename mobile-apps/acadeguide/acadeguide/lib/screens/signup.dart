import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/screens/register_verify.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthService _authService = AuthService();
  final Decorations _decorations = Decorations();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Animate(
            effects: [FadeEffect(duration: Duration(seconds: 1))],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 130, child: SvgPicture.asset(_decorations.logo)),
                  Text(
                    'R E G I S T R A T I O N',
                    style: TextStyle(color: Colors.amber, fontSize: 18),
                  )
                      .animate(
                        delay: 1000.ms,
                        onPlay: (controller) => controller.repeat(),
                      )
                      .tint(
                        color: Colors.lightBlue,
                        duration: 10.seconds,
                      )
                      .then(delay: 1.seconds)
                      .tint(
                        color: Colors.amber,
                        duration: 10.seconds,
                      ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _firstNameController,
                        decoration: _decorations.fieldEntry(
                            'First Name', Icon(Icons.person)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _lastNameController,
                        decoration: _decorations.fieldEntry(
                            'Last Name', Icon(Icons.person)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _usernameController,
                        decoration: _decorations.fieldEntry(
                            'Username', Icon(Icons.person_outline_outlined)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration:
                            _decorations.fieldEntry('Email', Icon(Icons.email)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                        obscureText: !_isPasswordVisible,
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            final firstName = _firstNameController.text;
                            final lastName = _lastNameController.text;
                            final username = _usernameController.text;

                            if (email.isEmpty ||
                                password.isEmpty ||
                                firstName.isEmpty ||
                                lastName.isEmpty ||
                                username.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  _decorations.bottomPopup(
                                      "Please fill the required information!",
                                      Colors.red,
                                      Colors.white));
                              return;
                            }

                            try {
                              await _authService
                                  .signup(
                                email: email,
                                password: password,
                                username: username,
                                firstname: firstName,
                                lastname: lastName,
                                interests: '',
                              )
                                  .then(
                                (value) {
                                  print(value?.user);
                                  if (value?.user != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        _decorations.bottomPopup(
                                            "Welcome to Acadeguide 🎓",
                                            Colors.green,
                                            Colors.white));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterVerify(),
                                      ),
                                    );
                                  }
                                },
                              );
                            } on PostgrestException catch (e) {
                              // Handle database errors
                              String errorMessage =
                                  "Sign up failed, Please try again!";

                              ScaffoldMessenger.of(context).showSnackBar(
                                  _decorations.bottomPopup(
                                      errorMessage, Colors.red, Colors.white));
                            } catch (e) {
                              // Handle any other errors
                              String errorMessage =
                                  "Sign up failed, Please try again!";

                              if (e.toString().contains(
                                  'Email or Username already registered')) {
                                errorMessage =
                                    "Email or Username already exists!";
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                  _decorations.bottomPopup(
                                      errorMessage, Colors.red, Colors.white));
                            }
                          },
                          style: _decorations.submitButtonStyle(),
                          child: _decorations.buttonText('R E G I S T E R'))
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
