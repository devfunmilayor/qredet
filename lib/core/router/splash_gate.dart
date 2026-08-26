import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SplashGate extends ChangeNotifier {
  SplashGate() {
    Timer(const Duration(seconds: 5), () {
      isReady = true;
      notifyListeners();
    });
  }

  bool isReady = false;
}
