import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'shopping_item.dart';

@immutable
class CartItem {
  final ShoppingItem item;
  final int quantity;

  const CartItem({
    required this.item,
    required this.quantity,
  });

  CartItem copyWith({
    ShoppingItem? item,
    int? quantity,
  }) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      item: ShoppingItem.fromMap(map['item']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));

  @override
  String toString() => 'CartItem(item: $item, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.item == item &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => item.hashCode ^ quantity.hashCode;
}
