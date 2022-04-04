import 'package:flutter/foundation.dart';
import 'package:flutter_simple_state_management/models/user_settings.dart';
import 'package:flutter_simple_state_management/models/user_settings_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_simple_state_management/models/user_state.dart';
import 'package:flutter_simple_state_management/state_management/service_locator.dart';
import 'store.dart';
import 'user_store.dart';

class UserSettingsStore extends Store<UserSettingsState> {
  final UserStore _userStore = ServiceLocator.get<UserStore>();
  late Function() _userStoreSubscription;

  UserSettingsStore() : super(UserSettingsState.initial()) {
    debugPrint('UserSettingsStore created');
    _userStoreSubscription = _userStore.addListener(_onUserStateChanged);
  }

  Future<void> getUserSettings(String uid) async {
    setState(state.copyWith(loading: true));
    await Future.delayed(const Duration(seconds: 2));
    // await FirebaseFirestore.instance.clearPersistence();
    final collection = FirebaseFirestore.instance.collection('userSettings');
    final res = await collection.doc(uid).get();
    final usrSettings = UserSettingsState(
      userSettings: UserSettings.fromMap(res.data()!),
      loading: false,
    );
    setState(usrSettings);
    debugPrint(usrSettings.toString());
  }

  _onUserStateChanged(UserState newState, UserState oldState) {
    if (newState.user == oldState.user) return;
    if (_userStore.currentUser != null) {
      getUserSettings(_userStore.currentUser!.uid);
    } else {
      setState(UserSettingsState.initial());
    }
  }

  @override
  dispose() {
    _userStore.removeListener(_userStoreSubscription);
    return super.dispose();
  }
}
