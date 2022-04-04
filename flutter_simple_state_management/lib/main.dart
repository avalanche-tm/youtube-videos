import 'package:flutter/material.dart';
import 'package:flutter_simple_state_management/data/database_init.dart';
import 'home.dart';
import 'login.dart';
import 'state_management/cart_store.dart';
import 'state_management/items_store.dart';
import 'state_management/service_locator.dart';
import 'state_management/user_settings_store.dart';
import 'state_management/user_store.dart';

void main() async {
  await configureFirebase(seedData: false);
  registerDependencies();
  runApp(MyApp());
}

void registerDependencies() {
  ServiceLocator.register<UserStore>(() => UserStore());
  ServiceLocator.register<UserSettingsStore>(() => UserSettingsStore());
  ServiceLocator.register<ItemsStore>(() => ItemsStore(), lazy: true);
  ServiceLocator.register<CartStore>(() => CartStore(), lazy: true);
}

class MyApp extends StatelessWidget {
  final userStore = ServiceLocator.get<UserStore>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          // contentPadding: EdgeInsets.all(5),
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: userStore.currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
