import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email = '';
  String? _emailError;
  String _password = '';
  String? _passwordError;
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;
  bool _errorMessageShown = false;
  bool _resetPasswordSuccess = false;
  String? _resetPasswordMessage;
  bool _resetPasswordInitiated = false; // Flag for initiated SnackBar
  bool _resetPasswordInitiatedShown = false; // Flag to track if shown

  // Getters
  String get email => _email;
  String? get emailError => _emailError;
  String get password => _password;
  String? get passwordError => _passwordError;
  bool get obscurePassword => _obscurePassword;
  bool get rememberMe => _rememberMe;
  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;
  bool get errorMessageShown => _errorMessageShown;
  bool get resetPasswordSuccess => _resetPasswordSuccess;
  String? get resetPasswordMessage => _resetPasswordMessage;
  bool get resetPasswordInitiated => _resetPasswordInitiated;
  bool get resetPasswordInitiatedShown => _resetPasswordInitiatedShown;

  void updateEmail(String email) {
    _email = email;
    _emailError = _validateEmail(email);
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    _passwordError = _validatePassword(password);
    notifyListeners();
  }

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void initiateResetPassword() {
    _resetPasswordInitiated = true;
    _resetPasswordInitiatedShown = false; // Reset shown flag
    notifyListeners();
  }

  void markResetPasswordInitiatedShown() {
    _resetPasswordInitiated = false;
    _resetPasswordInitiatedShown = true;
    notifyListeners();
  }

  Future<void> login() async {
    _emailError = _validateEmail(_email);
    _passwordError = _validatePassword(_password);

    if (_emailError != null || _passwordError != null) {
      _isLoading = false;
      _errorMessageShown = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    _errorMessageShown = false;
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(
        email: _email.trim(),
        password: _password,
      );
      _isLoading = false;
      _isSuccess = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Please enter a valid email address';
          break;
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'invalid-credential':
          message = 'Invalid email or password';
          break;
        default:
          message = 'Authentication failed: ${e.message}';
      }
      _isLoading = false;
      _errorMessage = message;
      _isSuccess = false;
      _errorMessageShown = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred.';
      _isSuccess = false;
      _errorMessageShown = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword() async {
    _emailError = _validateEmail(_email);
    if (_emailError != null) {
      _errorMessageShown = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _errorMessageShown = false;
    notifyListeners();

    try {
      await _auth.sendPasswordResetEmail(email: _email.trim());
      _isLoading = false;
      _resetPasswordSuccess = true;
      _resetPasswordMessage = 'Password reset email sent! Check your inbox.';
      notifyListeners();
      // Clear success state to prevent repeated triggers
      _resetPasswordSuccess = false;
      _resetPasswordMessage = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Please enter a valid email address';
          break;
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        default:
          message = 'Failed to send reset email: ${e.message}';
      }
      _isLoading = false;
      _errorMessage = message;
      _resetPasswordSuccess = false;
      _errorMessageShown = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred.';
      _resetPasswordSuccess = false;
      _errorMessageShown = false;
      notifyListeners();
    }
  }

  void clearErrorMessage() {
    _errorMessage = null;
    _errorMessageShown = false;
    notifyListeners();
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!email.contains('@') || !email.contains('.') || email.trim().length < 5) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}