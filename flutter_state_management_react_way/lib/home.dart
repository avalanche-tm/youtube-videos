import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'state/reducer.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _store = useReducer(reducer, initialState: State());

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('State Management'),
          ),
          backgroundColor: Colors.grey.shade100,
          body: ListView.builder(itemBuilder: itemBuilder)),
    );
  }
}
