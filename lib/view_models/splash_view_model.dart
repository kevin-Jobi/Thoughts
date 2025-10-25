import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  bool _isLoading = true;
  bool _isAuthenticated = false;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  SplashViewModel() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    _isAuthenticated = FirebaseAuth.instance.currentUser != null;
    _isLoading = false;
    notifyListeners();
  }
}