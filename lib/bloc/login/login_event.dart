// import 'package:equatable/equatable.dart';

// abstract class LoginEvent extends Equatable {
//   const LoginEvent();

//   @override
//   List<Object> get props => [];
// }

// class EmailChanged extends LoginEvent {
//   final String email;

//   const EmailChanged(this.email);

//   @override
//   List<Object> get props => [email];
// }

// class PasswordChanged extends LoginEvent {
//   final String password;

//   const PasswordChanged(this.password);

//   @override
//   List<Object> get props => [password];
// }

// class RememberMeToggled extends LoginEvent {
//   final bool value;

//   const RememberMeToggled(this.value);

//   @override
//   List<Object> get props => [value];
// }

// class TogglePasswordVisibility extends LoginEvent {}

// class LoginSubmitted extends LoginEvent {}

// class ResetPasswordRequested extends LoginEvent {}

// class ResetPasswordInitiated extends LoginEvent {} // New



abstract class LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);
}

class RememberMeToggled extends LoginEvent {
  final bool value;
  RememberMeToggled(this.value);
}

class TogglePasswordVisibility extends LoginEvent {}

class LoginSubmitted extends LoginEvent {}

class ResetPasswordRequested extends LoginEvent {}

class ResetPasswordInitiated extends LoginEvent {} // New