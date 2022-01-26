import 'package:flutter/material.dart';

class UseTabControllerEquivalent extends StatefulWidget {
  const UseTabControllerEquivalent({Key? key}) : super(key: key);

  @override
  _UseTabControllerEquivalentState createState() =>
      _UseTabControllerEquivalentState();
}

class _UseTabControllerEquivalentState extends State<UseTabControllerEquivalent>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;
  final int _numTabs = 3;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _numTabs, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
      debugPrint("Selected Index: " + _controller!.index.toString());
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
          bottom: TabBar(
            controller: _controller,
            tabs: const [
              Tab(icon: Icon(Icons.flight)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: const [
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_selectedIndex + 1 < _numTabs) {
              _controller!.animateTo(_selectedIndex += 1);
            }
          },
          child: const Icon(Icons.chevron_right_outlined),
        ),
      ),
    );
  }
}
