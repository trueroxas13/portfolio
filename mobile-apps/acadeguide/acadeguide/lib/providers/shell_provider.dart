import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShellNotifier extends Notifier <bool>{
  @override
  bool build() {
    return false;
  }

  void enable(){
    state = true;
  }

  void disable(){
    state = false;
  }
}

final shellNotifierProvider = NotifierProvider<ShellNotifier, bool>(() => ShellNotifier(),);