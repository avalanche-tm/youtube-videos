import 'package:flutter/material.dart';
import 'models/cart_item.dart';
import 'state_management/cart_store.dart';
import 'state_management/service_locator.dart';

class CartPage extends StatelessWidget {
  final cartStore = ServiceLocator.get<CartStore>();
  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('CartPage rebuilt');

    return ValueListenableBuilder(
      valueListenable: cartStore.notifier,
      builder: (context, List<CartItem> items, _) {
        return items.isEmpty
            ? const Center(child: Text('No items'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = items[index];
                        return _CartItem(item: item);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        onPressed: () => cartStore.checkout(),
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: Text(
                            'Checkout \$${cartStore.total}'.toUpperCase())),
                  )
                ],
              );
      },
    );
  }
}

class _CartItem extends StatelessWidget {
  _CartItem({Key? key, required this.item}) : super(key: key);
  final cartStore = ServiceLocator.get<CartStore>();
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  item.item.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Image.network(item.item.imageUrl),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  item.item.description,
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Quantity: ${item.quantity}'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Total: \$${item.item.price * item.quantity}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
                onPressed: () => cartStore.removeItemFromCart(item),
                icon: const Icon(Icons.delete_outline)),
          )
        ],
      ),
    );
  }
}
