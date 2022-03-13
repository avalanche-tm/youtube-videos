import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'cart_item.dart';

@immutable
class UserSettings {
  final String userId;
  final List<CartItem> cartItems;
  final List<CartItem> boughtItems;

  const UserSettings({
    required this.userId,
    required this.cartItems,
    required this.boughtItems,
  });

  factory UserSettings.initial() {
    return const UserSettings(userId: '', cartItems: [], boughtItems: []);
  }

  UserSettings copyWith({
    String? userId,
    List<CartItem>? cartItems,
    List<CartItem>? boughtItems,
  }) {
    return UserSettings(
      userId: userId ?? this.userId,
      cartItems: cartItems ?? this.cartItems,
      boughtItems: boughtItems ?? this.boughtItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'boughtItems': boughtItems.map((x) => x.toMap()).toList(),
    };
  }

  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      userId: map['userId'] ?? '',
      cartItems: List<CartItem>.from(
          map['cartItems']?.map((x) => CartItem.fromMap(x))),
      boughtItems: List<CartItem>.from(
          map['boughtItems']?.map((x) => CartItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
  factory UserSettings.fromJson(String source) =>
      UserSettings.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserSettings(userId: $userId, cartItems: $cartItems, boughtItems: $boughtItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserSettings &&
        other.userId == userId &&
        listEquals(other.cartItems, cartItems) &&
        listEquals(other.boughtItems, boughtItems);
  }

  @override
  int get hashCode =>
      userId.hashCode ^ cartItems.hashCode ^ boughtItems.hashCode;
}
