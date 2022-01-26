import 'package:flutter/material.dart';
import 'package:flutter_hooks_practical_examples/examples/animations_example.dart';
import 'package:flutter_hooks_practical_examples/examples/use_effect_example.dart';
import 'package:flutter_hooks_practical_examples/examples/http_resource_example.dart';
import 'package:flutter_hooks_practical_examples/examples/use_single_tick_provider_example.dart';
import 'package:flutter_hooks_practical_examples/examples/use_state_example.dart';
import 'package:flutter_hooks_practical_examples/examples/use_tab_controller_example.dart';
import 'package:flutter_hooks_practical_examples/examples/use_text_editing_controller_example.dart';
import 'package:flutter_hooks_practical_examples/examples/use_value_notifier_example.dart';
import 'package:flutter_hooks_practical_examples/home.dart';
import 'package:flutter_hooks_practical_examples/stateful_equivalents/use_effect_equivalent.dart';
import 'package:flutter_hooks_practical_examples/stateful_equivalents/use_state_equivalent.dart';
import 'package:flutter_hooks_practical_examples/stateful_equivalents/use_tab_controller_equivalent.dart';

import 'examples/example.dart';

void main() async {
  runApp(const MyApp());
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
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/exampleExample': (context) => MyHomePage(':('),
        '/useStateExample': (context) => UseStateExample(),
        '/useEffectExample': (context) => UseEffectExample(),
        '/useValueNotifierExample': (context) => UseValueNotifierExample(),
        '/httpResourceExample': (context) => HttpResourceExample(),
        '/useTextEditingControllerExample': (context) =>
            UseTextEditingcontrollerExample(),
        '/useTabControllerExample': (context) => UseTabControllerExample(),
        '/animationsExample': (context) => AnimationsExample(),
        '/useSingleTickProviderExample': (context) =>
            UseSingleTickProviderExample(),
        '/useEffectEquivalent': (context) => UseEffectEquivalent(),
        '/useStateEquivalent': (context) => UseStateEquivalent(),
        '/useTabControllerEquivalent': (context) =>
            UseTabControllerEquivalent(),
      },
    );
  }
}
