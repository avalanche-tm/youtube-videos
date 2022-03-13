import 'package:flutter/material.dart';
import 'package:flutter_simple_state_management/models/cart_item.dart';
import 'package:flutter_simple_state_management/models/user_settings_state.dart';
import 'package:flutter_simple_state_management/state_management/service_locator.dart';
import 'package:flutter_simple_state_management/state_management/user_settings_store.dart';

class AccountPage extends StatelessWidget {
  final _usrSettingsStore = ServiceLocator.get<UserSettingsStore>();
  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('AccountPage rebuilt');

    return ValueListenableBuilder(
      valueListenable: _usrSettingsStore.notifier,
      builder: (context, UserSettingsState state, _) {
        return state.userSettings.boughtItems.isEmpty
            ? const Center(child: Text('No items'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.userSettings.boughtItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = state.userSettings.boughtItems[index];
                        return _BoughtItem(cartItem: item);
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class _BoughtItem extends StatelessWidget {
  const _BoughtItem({Key? key, required this.cartItem}) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 180,
        child: Row(
          children: [
            Expanded(
              child: Image.network(cartItem.item.imageUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartItem.item.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      cartItem.item.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                    Text(
                      'Item price: \$${cartItem.item.price}',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Quantity: ${cartItem.quantity}'),
                    ),
                    Text(
                      'Total: \$${cartItem.item.price * cartItem.quantity}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
