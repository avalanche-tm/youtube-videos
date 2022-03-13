import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserState {
  final User? user;
  final bool loggingIn;
  final String loginError;

  const UserState({
    this.user,
    required this.loggingIn,
    required this.loginError,
  });

  factory UserState.initial() {
    return const UserState(loggingIn: false, loginError: '');
  }

  UserState copyWith({
    User? user,
    bool? loggingIn,
    String? loginError,
  }) {
    return UserState(
      user: user ?? this.user,
      loggingIn: loggingIn ?? this.loggingIn,
      loginError: loginError ?? this.loginError,
    );
  }
}
