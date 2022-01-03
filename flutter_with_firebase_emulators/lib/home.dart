import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  Future<void> testFirestore() async {
    await FirebaseFirestore.instance
        .collection('test-collection')
        .doc()
        .set({'data': 'test'});
  }

  Future<void> testStorage() async {
    String dir = (await getTemporaryDirectory()).path;
    File file = File('$dir/test.txt');
    String filename = '${DateTime.now().millisecondsSinceEpoch.toString()}.txt';
    await file.writeAsString('some text');

    await FirebaseStorage.instance.ref(filename).putFile(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Emulator Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async => await testFirestore(),
              child: const Text('Test Firestore'),
            ),
            ElevatedButton(
              onPressed: () async => await testStorage(),
              child: const Text('Test Storage'),
            ),
          ],
        ),
      ),
    );
  }
}
