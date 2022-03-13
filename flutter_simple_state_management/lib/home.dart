import 'package:flutter/material.dart';
import 'package:flutter_simple_state_management/listing.dart';
import 'account.dart';
import 'cart.dart';
import 'models/user_settings_state.dart';
import 'state_management/service_locator.dart';
import 'state_management/user_settings_store.dart';
import 'state_management/user_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userStore = ServiceLocator.get<UserStore>();
  final userSettingsStore = ServiceLocator.get<UserSettingsStore>();
  int _selectedIndex = 0;

  final _screens = [
    ListingPage(),
    CartPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint('HomePage rebuilt');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rare Items Store'),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return ['Logout'].map((choice) {
                  return PopupMenuItem(
                      value: choice,
                      child: Text(choice),
                      onTap: () {
                        userStore.signOut().then((value) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (route) => false);
                        });
                      });
                }).toList();
              },
            )
          ],
        ),
        backgroundColor: Colors.grey.shade100,
        body: ValueListenableBuilder<UserSettingsState>(
          valueListenable: userSettingsStore.notifier,
          builder: (context, value, _) {
            return value.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : IndexedStack(
                    index: _selectedIndex,
                    children: _screens,
                  );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Listing',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
