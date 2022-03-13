import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/items_state.dart';
import 'models/shopping_item.dart';
import 'state_management/cart_store.dart';
import 'state_management/items_store.dart';
import 'state_management/service_locator.dart';

class ListingPage extends StatelessWidget {
  final itemsStore = ServiceLocator.get<ItemsStore>();
  ListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('ListingPage rebuilt');

    return ValueListenableBuilder(
      valueListenable: itemsStore.notifier,
      builder: (context, ItemsState value, Widget? child) {
        return value.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => itemsStore.getShoppingItems(pullRefresh: true),
                child: ListView.builder(
                  itemCount: value.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = value.items[index];
                    return _Item(item: item);
                  },
                ),
              );
      },
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({Key? key, required this.item}) : super(key: key);

  final ShoppingItem item;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  final qtyController = TextEditingController(text: '1');
  final cartStore = ServiceLocator.get<CartStore>();

  @override
  void dispose() {
    qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 180,
        child: Row(
          children: [
            Expanded(
              child: Image.network(widget.item.imageUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.item.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      widget.item.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '\$${widget.item.price.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 35,
                            margin: const EdgeInsets.all(5),
                            child: TextField(
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(5)),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              controller: qtyController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text('/${widget.item.count}'),
                        ),
                        ElevatedButton.icon(
                          // onPressed: () {},
                          onPressed: widget.item.count > 0
                              ? () => cartStore.addItemToCart(
                                  widget.item, int.parse(qtyController.text))
                              : null,
                          icon: const Icon(Icons.add),
                          label: const Text('Add'),
                        ),
                      ],
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
