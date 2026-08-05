import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/user.dart';

class UserNotifier extends Notifier<User>{
  @override
  build() {
    return User.defaultUser();
  }
}

final userNotifierProvider = NotifierProvider<UserNotifier, User>(() => UserNotifier(),);