library cart_store;

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
  // late Function() _userStoreSubscription;

  CartStore() : super([]) {
    debugPrint('CartStore created');
    _usrSettingsStore.addListener(_onUserSettingsChanged);
    // watch(_usrSettingsStore, _onUserSettingsChanged);
  }

  // Future<void> getUserSettings(String uid) async {
  //   setState(state.copyWith(loading: true));
  //   await Future.delayed(const Duration(seconds: 2));
  //   // await FirebaseFirestore.instance.clearPersistence();
  //   final collection = FirebaseFirestore.instance.collection('userSettings');
  //   final res = await collection.doc(uid).get();
  //   final usrSettings = UserSettingsState(
  //     userSettings: UserSettings.fromMap(res.data()!),
  //     loading: false,
  //   );
  //   setState(usrSettings);
  //   debugPrint(usrSettings.toString());
  // }

  _onUserSettingsChanged(
      UserSettingsState newState, UserSettingsState oldState) {
    if (newState.userSettings.cartItems == oldState.userSettings.cartItems) {
      return;
    }
    setState(List.from(newState.userSettings.cartItems));
    // if (_userStore.currentUser != null) {
    //   getUserSettings(_userStore.currentUser!.uid);
    // } else {
    //   setState(UserSettingsState.initial());
    // }
  }

  Future<void> addItemToCart(ShoppingItem item, int quantity) async {
    final uid = _usrSettingsStore.state.userSettings.userId;
    final usrSettings = FirebaseFirestore.instance.collection('userSettings');
    // final items = FirebaseFirestore.instance.collection('items');

    final cartItem = CartItem(item: item, quantity: quantity);
    await usrSettings.doc(uid).update({
      'cartItems': FieldValue.arrayUnion([cartItem.toMap()])
    });

    // await items.doc(item.id).update({'count': FieldValue.increment(-quantity)});

    _itemsStore.updateQuantity(item.id, -quantity);
    setState([...state, cartItem]);
  }

  Future<void> removeItemFromCart(CartItem cartItem) async {
    final uid = _usrSettingsStore.state.userSettings.userId;
    final usrSettings = FirebaseFirestore.instance.collection('userSettings');
    // final items = FirebaseFirestore.instance.collection('items');

    await usrSettings.doc(uid).update({
      'cartItems': FieldValue.arrayRemove([cartItem.toMap()])
    });

    // await items
    //     .doc(cartItem.item.id)
    //     .update({'count': FieldValue.increment(cartItem.quantity)});

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

// final userSettingsStore = UserSettingsStore(userStore);
