import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseEffectExample extends HookWidget {
  final _change = true;
  const UseEffectExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      debugPrint('onInitState');
      return () => debugPrint('onDisposed');
    }, [_change]);

    useEffect(() {
      debugPrint('onInitState2');
      return () => debugPrint('onDisposed2');
    }, []);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
        ),
        body: const Center(child: Text('Check your debug console output!')),
      ),
    );
  }
}
