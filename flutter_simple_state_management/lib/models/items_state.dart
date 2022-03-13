import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_state_management/models/shopping_item.dart';

class ItemsState {
  final List<ShoppingItem> items;
  final bool loading;

  ItemsState({
    required this.items,
    required this.loading,
  });

  factory ItemsState.initial() {
    return ItemsState(items: [], loading: false);
  }

  ItemsState copyWith({
    List<ShoppingItem>? items,
    bool? loading,
  }) {
    return ItemsState(
      items: items ?? this.items,
      loading: loading ?? this.loading,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((x) => x.toMap()).toList(),
      'loading': loading,
    };
  }

  factory ItemsState.fromMap(Map<String, dynamic> map) {
    return ItemsState(
      items: List<ShoppingItem>.from(
          map['items']?.map((x) => ShoppingItem.fromMap(x))),
      loading: map['loading'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemsState.fromJson(String source) =>
      ItemsState.fromMap(json.decode(source));

  @override
  String toString() => 'ItemsState(items: $items, loading: $loading)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemsState &&
        listEquals(other.items, items) &&
        other.loading == loading;
  }

  @override
  int get hashCode => items.hashCode ^ loading.hashCode;
}
