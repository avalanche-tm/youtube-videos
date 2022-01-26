import 'package:flutter/material.dart';

class UseStateEquivalent extends StatelessWidget {
  const UseStateEquivalent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
        ),
        body: const SizedBox(
          width: double.infinity,
          child: _MyWidget(),
        ),
      ),
    );
  }
}

class _MyWidget extends StatefulWidget {
  const _MyWidget({Key? key}) : super(key: key);

  @override
  __MyWidgetState createState() => __MyWidgetState();
}

class __MyWidgetState extends State<_MyWidget> {
  bool toggle = false;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Visibility(
          visible: toggle,
          child: const Text('This text is invisible!'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              toggle = !toggle;
            });
          },
          child: const Text('Toggle Text Visibility'),
        ),
      ],
    );
  }
}
