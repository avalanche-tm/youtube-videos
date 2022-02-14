import 'package:flutter/foundation.dart';
import 'package:flutter_state_management_react_way/models/shopping_cart.dart';
import 'package:flutter_state_management_react_way/models/shopping_item.dart';

@immutable
class State {
  final List<ShoppingItem> items;
  final ShoppingCart cart;

  const State({
    required this.items,
    required this.cart,
  });

  State copyWith({
    List<ShoppingItem>? items,
    ShoppingCart? cart,
  }) {
    return State(
      items: items ?? this.items,
      cart: cart ?? this.cart,
    );
  }
}
