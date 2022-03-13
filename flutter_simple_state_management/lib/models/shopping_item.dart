import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class ShoppingItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final int count;

  const ShoppingItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.count,
  });

  ShoppingItem copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? description,
    int? count,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'count': count,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingItem.fromJson(String source) =>
      ShoppingItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShoppingItem(id: $id, name: $name, price: $price, imageUrl: $imageUrl, description: $description, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShoppingItem &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.description == description &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        description.hashCode ^
        count.hashCode;
  }
}
