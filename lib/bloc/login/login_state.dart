import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;
  final bool obscurePassword;
  final bool rememberMe;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final bool resetPasswordSuccess;
  final String? resetPasswordMessage;
  final bool resetPasswordInitiated; // New
  final bool resetPasswordInitiatedShown; // New

  const LoginState({
    this.email = '',
    this.emailError,
    this.password = '',
    this.passwordError,
    this.obscurePassword = true,
    this.rememberMe = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.resetPasswordSuccess = false,
    this.resetPasswordMessage,
    this.resetPasswordInitiated = false,
    this.resetPasswordInitiatedShown = false,
  });

  LoginState copyWith({
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    bool? obscurePassword,
    bool? rememberMe,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool? resetPasswordSuccess,
    String? resetPasswordMessage,
    bool? resetPasswordInitiated,
    bool? resetPasswordInitiatedShown,
  }) {
    return LoginState(
      email: email ?? this.email,
      emailError: emailError,
      password: password ?? this.password,
      passwordError: passwordError,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      resetPasswordSuccess: resetPasswordSuccess ?? this.resetPasswordSuccess,
      resetPasswordMessage: resetPasswordMessage,
      resetPasswordInitiated: resetPasswordInitiated ?? this.resetPasswordInitiated,
      resetPasswordInitiatedShown: resetPasswordInitiatedShown ?? this.resetPasswordInitiatedShown,
    );
  }

  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        passwordError,
        obscurePassword,
        rememberMe,
        isLoading,
        isSuccess,
        errorMessage,
        resetPasswordSuccess,
        resetPasswordMessage,
        resetPasswordInitiated,
        resetPasswordInitiatedShown,
      ];
}