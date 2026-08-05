import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssessedNotifier extends Notifier <bool>{
  @override
  bool build() {
    return false;
  }

  void setFalse(){
    state = false;
  }

  void setTrue(){
    state = true;
  }
}

final assessedNotifierProvider = NotifierProvider<AssessedNotifier, bool>(() => AssessedNotifier(),);