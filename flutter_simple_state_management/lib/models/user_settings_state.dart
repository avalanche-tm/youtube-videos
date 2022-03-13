import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'user_settings.dart';

@immutable
class UserSettingsState {
  final UserSettings userSettings;
  final bool loading;

  const UserSettingsState({
    required this.userSettings,
    required this.loading,
  });

  factory UserSettingsState.initial() {
    return UserSettingsState(
      userSettings: UserSettings.initial(),
      loading: false,
    );
  }

  UserSettingsState copyWith({
    UserSettings? userSettings,
    bool? loading,
  }) {
    return UserSettingsState(
      userSettings: userSettings ?? this.userSettings,
      loading: loading ?? this.loading,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userSettings': userSettings.toMap(),
      'loading': loading,
    };
  }

  factory UserSettingsState.fromMap(Map<String, dynamic> map) {
    return UserSettingsState(
      userSettings: UserSettings.fromMap(map['userSettings']),
      loading: map['loading'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());
  factory UserSettingsState.fromJson(String source) =>
      UserSettingsState.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserSettingsState(userSettings: $userSettings, loading: $loading)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserSettingsState &&
        other.userSettings == userSettings &&
        other.loading == loading;
  }

  @override
  int get hashCode => userSettings.hashCode ^ loading.hashCode;
}
