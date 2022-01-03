import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<bool> signIn() async {
    final creds = await FirebaseAuth.instance.signInAnonymously();
    debugPrint(creds.user?.uid);
    if (creds.user != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final success = await signIn();
                if (success) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
