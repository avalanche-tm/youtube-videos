import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_practical_examples/dummy_api.dart';

class HttpResourceExample extends HookWidget {
  const HttpResourceExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = useMemoized(() => DummyApi());
    final httpCall = useValueNotifier(apiService.getHttpResource());

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
                  final future = useValueListenable(httpCall);
                  return FutureBuilder(
                    future: future,
                    builder: (_, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!);
                        } else {
                          return Text(snapshot.error != null
                              ? snapshot.error as String
                              : 'Unknown error');
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  httpCall.value = apiService.getHttpResource();
                },
                child: const Text('Request HTTP Resource'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
