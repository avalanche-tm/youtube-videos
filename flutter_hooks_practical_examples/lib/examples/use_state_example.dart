import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseStateExample extends HookWidget {
  const UseStateExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: HookBuilder(
            builder: (_) {
              final toggle = useState(false);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: toggle.value,
                    child: const Text('This text is invisible!'),
                  ),
                  ElevatedButton(
                    onPressed: () => toggle.value = !toggle.value,
                    child: const Text('Toggle Text Visibility'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
