import 'package:flutter/material.dart';

class UseEffectEquivalent extends StatefulWidget {
  const UseEffectEquivalent({Key? key}) : super(key: key);

  @override
  _UseEffectEquivalentState createState() => _UseEffectEquivalentState();
}

class _UseEffectEquivalentState extends State<UseEffectEquivalent> {
  @override
  void initState() {
    super.initState();
    debugPrint('onInitState');
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('onDisposed');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
        ),
        body: const Center(
          child: Text('setState equivalent of useEffect'),
        ),
      ),
    );
  }
}
