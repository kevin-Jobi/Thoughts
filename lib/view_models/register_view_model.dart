import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _name = '';
  String? _nameError;
  String _company = '';
  String? _companyError;
  String _email = '';
  String? _emailError;
  String _password = '';
  String? _passwordError;
  String _confirmPassword = '';
  String? _confirmPasswordError;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;
  String? _termsError;
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;
  bool _successMessageShown = false; // New flag to track success SnackBar
  bool _errorMessageShown = false; // New flag for error SnackBar

  // Getters
  String get name => _name;
  String? get nameError => _nameError;
  String get company => _company;
  String? get companyError => _companyError;
  String get email => _email;
  String? get emailError => _emailError;
  String get password => _password;
  String? get passwordError => _passwordError;
  String get confirmPassword => _confirmPassword;
  String? get confirmPasswordError => _confirmPasswordError;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get termsAccepted => _termsAccepted;
  String? get termsError => _termsError;
  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;
  bool get successMessageShown => _successMessageShown; // Getter for new flag
  bool get errorMessageShown => _errorMessageShown;

  void updateName(String name) {
    _name = name;
    _nameError = name.isEmpty ? 'Name is required' : null;
    notifyListeners();
  }

  void updateCompany(String company) {
    _company = company;
    _companyError = company.isEmpty ? 'Company name is required' : null;
    notifyListeners();
  }

  void updateEmail(String email) {
    _email = email;
    _emailError = _validateEmail(email);
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    _passwordError = _validatePassword(password);
    _confirmPasswordError = _validateConfirmPassword(
      _confirmPassword,
      password,
    );
    notifyListeners();
  }

  void updateConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    _confirmPasswordError = _validateConfirmPassword(
      confirmPassword,
      _password,
    );
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void toggleTerms(bool accepted) {
    _termsAccepted = accepted;
    _termsError = !accepted ? 'You must accept the terms and conditions' : null;
    notifyListeners();
  }

  Future<void> register() async {
    _nameError = _name.isEmpty ? 'Name is required' : null;
    _companyError = _company.isEmpty ? 'Company name is required' : null;
    _emailError = _validateEmail(_email);
    _passwordError = _validatePassword(_password);
    _confirmPasswordError = _validateConfirmPassword(
      _confirmPassword,
      _password,
    );
    _termsError = !_termsAccepted
        ? 'You must accept the terms and conditions'
        : null;

    if (_nameError != null ||
        _companyError != null ||
        _emailError != null ||
        _passwordError != null ||
        _confirmPasswordError != null ||
        _termsError != null) {
      _isLoading = false;
      _errorMessageShown = false; // Reset error flag
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    _successMessageShown = false; // Reset flag on new registration attempt
    _errorMessageShown = false; // Reset error flag
    notifyListeners();

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _email.trim(),
        password: _password,
      );
      _isLoading = false;
      _isSuccess = true;
      _successMessageShown = false; // Ensure flag is reset for new success
      _errorMessageShown = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Please enter a valid email address';
          break;
        case 'email-already-in-use':
          message = 'Email is already registered';
          break;
        case 'weak-password':
          message = 'Password must be at least 6 characters';
          break;
        default:
          message = 'Registration failed: ${e.message}';
      }
      _isLoading = false;
      _errorMessage = message;
      _isSuccess = false;
      _errorMessageShown = false; // Reset error flag
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred.';
      _isSuccess = false;
      _errorMessageShown = false; // Reset error flag
      notifyListeners();
    }
  }

  void markSuccessMessageShown() {
    _successMessageShown = true;
    notifyListeners();
  }

  void markErrorMessageShown() {
    _errorMessageShown = true;
    notifyListeners();
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!email.contains('@') ||
        !email.contains('.') ||
        email.trim().length < 5) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) return 'Confirm password is required';
    if (confirmPassword != password) return 'Passwords do not match';
    return null;
  }
}
