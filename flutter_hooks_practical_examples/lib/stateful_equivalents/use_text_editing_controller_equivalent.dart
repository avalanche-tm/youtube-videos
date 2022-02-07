import 'package:flutter/material.dart';

class UseTextEditingControllerEquivalent extends StatefulWidget {
  const UseTextEditingControllerEquivalent({Key? key}) : super(key: key);

  @override
  _UseTextEditingControllerEquivalentState createState() =>
      _UseTextEditingControllerEquivalentState();
}

class _UseTextEditingControllerEquivalentState
    extends State<UseTextEditingControllerEquivalent> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Hooks Examples'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
              ),
              TextField(
                controller: passwordController,
              ),
              ElevatedButton(
                onPressed: () {
                  final usr = usernameController.text;
                  final pwd = passwordController.text;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Logged in with $usr and $pwd'),
                    ),
                  );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
