import 'package:flutter/foundation.dart';
import 'package:flutter_simple_state_management/models/items_state.dart';
import 'package:flutter_simple_state_management/models/shopping_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'store.dart';

class ItemsStore extends Store<ItemsState> {
  ItemsStore() : super(ItemsState.initial()) {
    debugPrint('ItemsStore created');
    getShoppingItems();
  }

  Future<void> getShoppingItems({bool pullRefresh = false}) async {
    if (!pullRefresh) setState(state.copyWith(loading: true));
    await Future.delayed(const Duration(seconds: 2));
    final collection = FirebaseFirestore.instance.collection('items');
    final res = await collection.get();
    final itemsState = ItemsState(
      items: List.from(res.docs.map((e) => ShoppingItem.fromMap(e.data())))
        ..shuffle(),
      loading: false,
    );
    setState(itemsState);
    debugPrint(itemsState.toString());
  }

  void updateQuantity(String itemId, int amount) {
    var itemsCopy = [...state.items];
    var idx = itemsCopy.indexWhere((element) => element.id == itemId);
    if (idx >= 0) {
      itemsCopy[idx] =
          itemsCopy[idx].copyWith(count: itemsCopy[idx].count + amount);
      setState(state.copyWith(items: itemsCopy));
    }
  }
}
