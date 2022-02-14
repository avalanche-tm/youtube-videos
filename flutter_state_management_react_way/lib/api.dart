import 'package:flutter/foundation.dart';
import 'models/shopping_item.dart';

class Api {
  static final Api _api = Api._internal();

  factory Api() {
    debugPrint('API object created');
    return _api;
  }

  Api._internal();

  // Api() {
  //   debugPrint('API object created');
  // }
  Future<List<ShoppingItem>> getItems() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => getMockShoppingItems(),
    );
  }
}
