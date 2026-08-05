import 'package:acadeguide/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends Notifier <bool>{
  AuthService authService = AuthService(); 
  @override
  bool build() {
    String? user = authService.getUser();
    return user!.isNotEmpty;
  }

  void login(){
    state = true;
  }

  void logout(){
    state = false;
  }
}

final loginNotifierProvider = NotifierProvider<LoginNotifier, bool>(() => LoginNotifier(),);