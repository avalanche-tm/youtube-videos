import 'package:flutter/material.dart';

class HookExample {
  final String title;
  final String route;
  final String description;
  HookExample(this.title, this.route, this.description);
}

class HomePage extends StatelessWidget {
  final List<HookExample> examples = [
    HookExample('useEffect', '/useEffect', 'How to use useEffect'),
    HookExample('useState', '/useState', 'How to use useState'),
    HookExample(
        'useValueNotifier', '/useValueNotifier', 'How to use useValueNotifier'),
    HookExample('Http Example', '/httpResource',
        'How to use useMemoized, useFuture and useStream hooks'),
    HookExample('useTextEditingController', '/useTextEditingController',
        'How to useTextEditingController'),
    HookExample(
        'useTabController', '/useTabController', 'How to useTabController'),
    HookExample('Animations', '/animations', 'How to useAnimationsController'),
    HookExample('useSingleTickProvider', '/useSingleTickProvider',
        'How to useSingleTickProvider'),
  ];
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
        ),
        backgroundColor: Colors.grey.shade100,
        body: ListView.builder(
            itemCount: examples.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            examples[index].title,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            examples[index].description,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    examples[index].route + 'Example');
                              },
                              child: const Text('HOOKS'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    examples[index].route + 'Equivalent');
                              },
                              child: const Text('SET STATE'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
