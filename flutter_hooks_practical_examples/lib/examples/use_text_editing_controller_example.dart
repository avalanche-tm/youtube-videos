import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseTextEditingcontrollerExample extends HookWidget {
  const UseTextEditingcontrollerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
        ),
        body: SizedBox(
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
