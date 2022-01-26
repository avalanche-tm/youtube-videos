import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimationsExample extends HookWidget {
  const AnimationsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
        ),
        body: const Center(
          child: _CircleButton(),
        ),
      ),
    );
  }
}

class _CircleButton extends HookWidget {
  const _CircleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    final animation =
        useMemoized(() => Tween(begin: 2.0, end: 15.0).animate(controller));
    final recording = useState(false);

    return SizedBox(
      height: 100,
      width: 100,
      child: AnimatedBuilder(
        animation: animation,
        child: MaterialButton(
          textColor: Colors.white,
          onPressed: () => recording.value = !recording.value,
          color: Colors.red.shade900,
          child: recording.value
              ? const Icon(Icons.stop_rounded, size: 35)
              : const Icon(Icons.mic, size: 35),
          shape: const CircleBorder(),
        ),
        builder: (context, child) {
          return Container(
            decoration: ShapeDecoration(
                color: Colors.red.shade900,
                shape: const CircleBorder(),
                shadows: [
                  if (recording.value)
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      spreadRadius: animation.value,
                      blurRadius: animation.value,
                    ),
                ]),
            child: child,
          );
        },
      ),
    );
  }
}
