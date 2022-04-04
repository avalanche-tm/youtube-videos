import 'package:flutter/foundation.dart';
import 'package:flutter_simple_state_management/models/shopping_item.dart';
import 'package:flutter_simple_state_management/models/user_settings_state.dart';
import 'package:flutter_simple_state_management/state_management/items_store.dart';
import 'package:flutter_simple_state_management/state_management/service_locator.dart';
import '../models/cart_item.dart';
import 'store.dart';
import 'user_settings_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartStore extends Store<List<CartItem>> {
  final _usrSettingsStore = ServiceLocator.get<UserSettingsStore>();
  final _itemsStore = ServiceLocator.get<ItemsStore>();

  CartStore() : super([]) {
    debugPrint('CartStore created');
    _usrSettingsStore.addListener(_onUserSettingsChanged);
  }

  _onUserSettingsChanged(
      UserSettingsState newState, UserSettingsState oldState) {
    if (newState.userSettings.cartItems == oldState.userSettings.cartItems) {
      return;
    }
    setState(List.from(newState.userSettings.cartItems));
  }

  Future<void> addItemToCart(ShoppingItem item, int quantity) async {
    final uid = _usrSettingsStore.state.userSettings.userId;
    final usrSettings = FirebaseFirestore.instance.collection('userSettings');

    final cartItem = CartItem(item: item, quantity: quantity);
    await usrSettings.doc(uid).update({
      'cartItems': FieldValue.arrayUnion([cartItem.toMap()])
    });

    _itemsStore.updateQuantity(item.id, -quantity);
    setState([...state, cartItem]);
  }

  Future<void> removeItemFromCart(CartItem cartItem) async {
    final uid = _usrSettingsStore.state.userSettings.userId;
    final usrSettings = FirebaseFirestore.instance.collection('userSettings');

    await usrSettings.doc(uid).update({
      'cartItems': FieldValue.arrayRemove([cartItem.toMap()])
    });

    _itemsStore.updateQuantity(cartItem.item.id, cartItem.quantity);
    setState([...state]
      ..removeWhere((element) => element.item.id == cartItem.item.id));
  }

  Future<void> checkout() async {
    final uid = _usrSettingsStore.state.userSettings.userId;
    final usrSettings = FirebaseFirestore.instance.collection('userSettings');
    final items = FirebaseFirestore.instance.collection('items');

    await usrSettings.doc(uid).update({
      'boughtItems': FieldValue.arrayUnion(state.map((e) => e.toMap()).toList())
    });
    await usrSettings.doc(uid).update({'cartItems': []});

    for (var cartItem in state) {
      await items
          .doc(cartItem.item.id)
          .update({'count': FieldValue.increment(-cartItem.quantity)});
    }

    _usrSettingsStore.getUserSettings(uid);
  }

  double get total {
    return state.isNotEmpty
        ? state.map((e) => e.quantity * e.item.price).reduce((a, b) => a + b)
        : 0;
  }

  @override
  dispose() {
    return super.dispose();
  }
}
