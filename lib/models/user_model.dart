import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Equatable {
  final String? uid;
  final String? email;

  const UserModel({this.uid, this.email});

  factory UserModel.fromFirebaseUser(User? user) {
    return UserModel(
      uid: user?.uid,
      email: user?.email,
    );
  }

  @override
  List<Object?> get props => [uid, email];
}