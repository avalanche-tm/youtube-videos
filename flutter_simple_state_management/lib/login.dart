import 'package:flutter/material.dart';
import 'models/user_state.dart';
import 'state_management/service_locator.dart';
import 'state_management/user_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userStore = ServiceLocator.get<UserStore>();

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
    debugPrint('HomePage rebuilt');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: ValueListenableBuilder<UserState>(
            valueListenable: userStore.notifier,
            builder: (context, value, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  if (value.loginError.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value.loginError,
                        style: TextStyle(color: Colors.red.shade800),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (!value.loggingIn) {
                        userStore
                            .signInWithEmail(
                          usernameController.text,
                          passwordController.text,
                        )
                            .then((value) {
                          if (value != null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (route) => false);
                          }
                        });
                      }
                    },
                    child: !value.loggingIn
                        ? const Text('Login')
                        : const SizedBox(
                            height: 16,
                            width: 16,
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
