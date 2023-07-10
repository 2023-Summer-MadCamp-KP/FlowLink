import 'package:flutter/material.dart';

//'현재 숫자: ${context.watch<Counter>().count} 처럼 사용
class UserProvider extends ChangeNotifier {
  bool _isSignIn = false;
  bool get isSignIn => _isSignIn;
  void setSignIn(bool isSignIn) {
    _isSignIn = isSignIn;
    notifyListeners();
  }
}
