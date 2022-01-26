import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseTabControllerExample extends HookWidget {
  const UseTabControllerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 3);
    useEffect(() {
      tabController.addListener(() {
        debugPrint('Selected index: ${tabController.index}');
      });
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
          bottom: TabBar(
            controller: tabController,
            tabs: const [
              Tab(icon: Icon(Icons.flight)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final selectedIdx = tabController.index;
            if (selectedIdx + 1 < tabController.length) {
              tabController.animateTo(selectedIdx + 1);
            }
          },
          child: const Icon(Icons.chevron_right_outlined),
        ),
      ),
    );
  }
}
