library user_store;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_state_management/models/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'store.dart';

class UserStore extends Store<UserState> {
  late StreamSubscription _userSubscription;

  UserStore() : super(UserState.initial()) {
    debugPrint('UserStore created');
    _userSubscription =
        FirebaseAuth.instance.authStateChanges().listen(_onUserChanged);
  }

  _onUserChanged(User? user) {
    if (user == null) {
      debugPrint('User is currently signed out!');
    } else {
      debugPrint('User is signed in!');
    }
    setState(state.copyWith(user: user));
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    setState(state.copyWith(loggingIn: true, loginError: ''));

    UserCredential? userCredential;
    await Future.delayed(const Duration(seconds: 2));
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      setState(
        state.copyWith(loginError: 'Authentication failed'),
      );
    }
    setState(state.copyWith(loggingIn: false));
    return userCredential;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  dispose() {
    _userSubscription.cancel();
    return super.dispose();
  }
}

// final userStore = UserStore();
