import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalla_pay/model/user.dart';
import 'package:yalla_pay/repo/streamvault_repository.dart';

class UserNotifier extends Notifier<List<User>> {
  @override

  late final StreamVaultRepository _repository;
    List<User> build(){
      return [];
    }



  void addUser(User user) async{
    await _repository.addUser(user);
  }
  
  void deleteUser(User user) async{
    await _repository.deleteUser(user);
  }
 
  void updateUser(User user) async {
    await _repository.updateUser(user);
  }
}

final userNotifierProvider =
    NotifierProvider<UserNotifier, List<User>>(() => UserNotifier());