import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (const bool.fromEnvironment("USE_FIREBASE_EMU")) {
    await _configureFirebaseAuth();
    await _configureFirebaseStorage();
    _configureFirebaseFirestore();
  }

  runApp(const MyApp());
}

Future<void> _configureFirebaseAuth() async {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("AUTH_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 9099;
  await FirebaseAuth.instance.useAuthEmulator(host, port);
  debugPrint('Using Firebase Auth emulator on: $host:$port');
}

Future<void> _configureFirebaseStorage() async {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("STORAGE_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 9199;
  await FirebaseStorage.instance.useStorageEmulator(host, port);
  debugPrint('Using Firebase Storage emulator on: $host:$port');
}

void _configureFirebaseFirestore() {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("DB_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 8080;

  FirebaseFirestore.instance.settings = Settings(
    host: '$host:$port',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  debugPrint('Using Firebase Firestore emulator on: $host:$port');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const MyHomePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
