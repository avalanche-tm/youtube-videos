import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseValueNotifierExample extends HookWidget {
  const UseValueNotifierExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toggleVN = useValueNotifier(false);
    useEffect(() {
      debugPrint('onInitState');
      return () => debugPrint('onDisposed');
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HookBuilder(
                builder: (_) {
                  final toggle = useValueListenable(toggleVN);
                  return Visibility(
                    visible: toggle,
                    child: const Text('This text is invisible!'),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () => toggleVN.value = !toggleVN.value,
                child: const Text('Toggle Text Visibility'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
