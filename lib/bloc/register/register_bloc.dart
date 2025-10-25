
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RegisterBloc() : super(const RegisterState()) {
    on<NameChanged>(
      (e, emit) => emit(state.copyWith(name: e.name, nameError: null)),
    );
    on<CompanyChanged>(
      (e, emit) => emit(state.copyWith(company: e.company, companyError: null)),
    );
    on<EmailChanged>((e, emit) {
      final emailError = _validateEmail(e.email);
      emit(state.copyWith(email: e.email, emailError: emailError));
    });
    on<PasswordChanged>((e, emit) {
      final passwordError = _validatePassword(e.password);
      emit(state.copyWith(password: e.password, passwordError: passwordError));
    });
    on<ConfirmPasswordChanged>((e, emit) {
      final confirmPasswordError = _validateConfirmPassword(
        e.confirmPassword,
        state.password,
      );
      emit(
        state.copyWith(
          confirmPassword: e.confirmPassword,
          confirmPasswordError: confirmPasswordError,
        ),
      );
    });
    on<TermsToggled>(
      (e, emit) =>
          emit(state.copyWith(termsAccepted: e.accepted, termsError: null)),
    );
    on<TogglePasswordVisibility>(
      (e, emit) =>
          emit(state.copyWith(obscurePassword: !state.obscurePassword)),
    );
    on<ToggleConfirmPasswordVisibility>(
      (e, emit) => emit(
        state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword),
      ),
    );

    on<RegisterSubmitted>((event, emit) async {
      // Validate all fields before submission
      final nameError = state.name.isEmpty ? 'Name is required' : null;
      final companyError = state.company.isEmpty
          ? 'Company name is required'
          : null;
      final emailError = _validateEmail(state.email);
      final passwordError = _validatePassword(state.password);
      final confirmPasswordError = _validateConfirmPassword(
        state.confirmPassword,
        state.password,
      );
      final termsError = !state.termsAccepted
          ? 'You must accept the terms and conditions'
          : null;

      if (nameError != null ||
          companyError != null ||
          emailError != null ||
          passwordError != null ||
          confirmPasswordError != null ||
          termsError != null) {
        emit(
          state.copyWith(
            nameError: nameError,
            companyError: companyError,
            emailError: emailError,
            passwordError: passwordError,
            confirmPasswordError: confirmPasswordError,
            termsError: termsError,
            isLoading: false,
          ),
        );
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));

      try {
        await _auth.createUserWithEmailAndPassword(
          email: state.email.trim(),
          password: state.password,
        );
        emit(
          state.copyWith(isLoading: false, isSuccess: true, errorMessage: null),
        );
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
        
          case 'invalid-email':
        message = 'Please enter a valid email address';
        break;
      case 'weak-password':
        message = 'Password should be at least 6 characters';
        break;
      case 'email-already-in-use':
        message = 'Email is already registered';
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
        emit(state.copyWith(isLoading: false, errorMessage: message));
      } catch (e) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'An unexpected error occurred.',
          ),
        );
      }
    });
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
