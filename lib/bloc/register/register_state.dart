

import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String name;
  final String? nameError;
  final String company;
  final String? companyError;
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;
  final String confirmPassword;
  final String? confirmPasswordError;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool termsAccepted;
  final String? termsError;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const RegisterState({
    this.name = '',
    this.nameError,
    this.company = '',
    this.companyError,
    this.email = '',
    this.emailError,
    this.password = '',
    this.passwordError,
    this.confirmPassword = '',
    this.confirmPasswordError,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.termsAccepted = false,
    this.termsError,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? name,
    String? nameError,
    String? company,
    String? companyError,
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
    String? confirmPassword,
    String? confirmPasswordError,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? termsAccepted,
    String? termsError,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegisterState(
      name: name ?? this.name,
      nameError: nameError,
      company: company ?? this.company,
      companyError: companyError,
      email: email ?? this.email,
      emailError: emailError,
      password: password ?? this.password,
      passwordError: passwordError,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      confirmPasswordError: confirmPasswordError,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      termsError: termsError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        nameError,
        company,
        companyError,
        email,
        emailError,
        password,
        passwordError,
        confirmPassword,
        confirmPasswordError,
        obscurePassword,
        obscureConfirmPassword,
        termsAccepted,
        termsError,
        isLoading,
        isSuccess,
        errorMessage,
      ];
}