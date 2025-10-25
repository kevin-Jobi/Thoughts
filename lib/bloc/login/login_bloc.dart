// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'login_event.dart';
// import 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   LoginBloc() : super(const LoginState()) {
//     on<EmailChanged>((event, emit) {
//       final emailError = _validateEmail(event.email);
//       emit(state.copyWith(email: event.email, emailError: emailError));
//     });

//     on<PasswordChanged>((event, emit) {
//       final passwordError = _validatePassword(event.password);
//       emit(state.copyWith(password: event.password, passwordError: passwordError));
//     });

//     on<RememberMeToggled>((event, emit) {
//       emit(state.copyWith(rememberMe: event.value));
//     });

//     on<TogglePasswordVisibility>((event, emit) {
//       emit(state.copyWith(obscurePassword: !state.obscurePassword));
//     });

//     on<LoginSubmitted>((event, emit) async {
//       final emailError = _validateEmail(state.email);
//       final passwordError = _validatePassword(state.password);

//       if (emailError != null || passwordError != null) {
//         emit(state.copyWith(
//           emailError: emailError,
//           passwordError: passwordError,
//           isLoading: false,
//         ));
//         return;
//       }

//       emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

//       try {
//         await _auth.signInWithEmailAndPassword(
//           email: state.email.trim(),
//           password: state.password,
//         );
//         emit(state.copyWith(isLoading: false, isSuccess: true, errorMessage: null));
//       } on FirebaseAuthException catch (e) {
//         String message;
//         switch (e.code) {
//           case 'invalid-email':
//             message = 'Please enter a valid email address';
//             break;
//           case 'user-not-found':
//             message = 'No user found with this email';
//             break;
//           case 'wrong-password':
//             message = 'Incorrect password';
//             break;
//           case 'invalid-credential':
//             message = 'Invalid email or password';
//             break;
//           default:
//             message = 'Authentication failed: ${e.message}';
//         }
//         emit(state.copyWith(isLoading: false, errorMessage: message, isSuccess: false));
//       } catch (e) {
//         emit(state.copyWith(
//           isLoading: false,
//           errorMessage: 'An unexpected error occurred.',
//           isSuccess: false,
//         ));
//       }
//     });

//     on<ResetPasswordInitiated>((event, emit) {
//       emit(state.copyWith(
//         resetPasswordInitiated: true,
//         resetPasswordInitiatedShown: false,
//       ));
//     });

//     on<ResetPasswordRequested>((event, emit) async {
//       final emailError = _validateEmail(state.email);
//       if (emailError != null) {
//         emit(state.copyWith(emailError: emailError, errorMessage: null));
//         return;
//       }

//       emit(state.copyWith(isLoading: true, errorMessage: null));

//       try {
//         await _auth.sendPasswordResetEmail(email: state.email.trim());
//         emit(state.copyWith(
//           isLoading: false,
//           errorMessage: null,
//           resetPasswordSuccess: true,
//           resetPasswordMessage: 'Password reset email sent! Check your inbox.',
//         ));
//         emit(state.copyWith(
//           resetPasswordSuccess: false,
//           resetPasswordMessage: null,
//         ));
//       } on FirebaseAuthException catch (e) {
//         String message;
//         switch (e.code) {
//           case 'invalid-email':
//             message = 'Please enter a valid email address';
//             break;
//           case 'user-not-found':
//             message = 'No user found with this email';
//             break;
//           default:
//             message = 'Failed to send reset email: ${e.message}';
//         }
//         emit(state.copyWith(
//           isLoading: false,
//           errorMessage: message,
//           resetPasswordSuccess: false,
//         ));
//       } catch (e) {
//         emit(state.copyWith(
//           isLoading: false,
//           errorMessage: 'An unexpected error occurred.',
//           resetPasswordSuccess: false,
//         ));
//       }
//     });
//   }

//   String? _validateEmail(String email) {
//     if (email.isEmpty) return 'Email is required';
//     if (!email.contains('@') || !email.contains('.') || email.trim().length < 5) {
//       return 'Please enter a valid email';
//     }
//     return null;
//   }

//   String? _validatePassword(String password) {
//     if (password.isEmpty) return 'Password is required';
//     if (password.length < 6) return 'Password must be at least 6 characters';
//     return null;
//   }
// }



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      final emailError = _validateEmail(event.email);
      emit(state.copyWith(email: event.email, emailError: emailError));
    });

    on<PasswordChanged>((event, emit) {
      final passwordError = _validatePassword(event.password);
      emit(state.copyWith(password: event.password, passwordError: passwordError));
    });

    on<RememberMeToggled>((event, emit) {
      emit(state.copyWith(rememberMe: event.value));
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(obscurePassword: !state.obscurePassword));
    });

    on<LoginSubmitted>((event, emit) async {
      final emailError = _validateEmail(state.email);
      final passwordError = _validatePassword(state.password);

      if (emailError != null || passwordError != null) {
        emit(state.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          isLoading: false,
        ));
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

      try {
        await _auth.signInWithEmailAndPassword(
          email: state.email.trim(),
          password: state.password,
        );
        emit(state.copyWith(isLoading: false, isSuccess: true, errorMessage: null));
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
        emit(state.copyWith(isLoading: false, errorMessage: message, isSuccess: false));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred.',
          isSuccess: false,
        ));
      }
    });

    on<ResetPasswordInitiated>((event, emit) {
      emit(state.copyWith(
        resetPasswordInitiated: true,
        resetPasswordInitiatedShown: false,
      ));
    });

    on<ResetPasswordRequested>((event, emit) async {
      final emailError = _validateEmail(state.email);
      if (emailError != null) {
        emit(state.copyWith(emailError: emailError, errorMessage: null));
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));

      try {
        await _auth.sendPasswordResetEmail(email: state.email.trim());
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          resetPasswordSuccess: true,
          resetPasswordMessage: 'Password reset email sent! Check your inbox.',
        ));
        emit(state.copyWith(
          resetPasswordSuccess: false,
          resetPasswordMessage: null,
        ));
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
        emit(state.copyWith(
          isLoading: false,
          errorMessage: message,
          resetPasswordSuccess: false,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred.',
          resetPasswordSuccess: false,
        ));
      }
    });
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