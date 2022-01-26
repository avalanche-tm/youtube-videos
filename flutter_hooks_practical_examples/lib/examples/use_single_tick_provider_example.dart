import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_practical_examples/custom_hooks.dart';

class UseSingleTickProviderExample extends HookWidget {
  const UseSingleTickProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: HookBuilder(
            builder: (_) {
              final recording = useState(false);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CircleButton(recording),
                  _ElapsedTimeLabel(recording),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends HookWidget {
  final ValueNotifier<bool> recording;
  const _CircleButton(this.recording, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('_CircleButton rebuilt.');
    final controller =
        useAnimationController(duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    final animation =
        useMemoized(() => Tween(begin: 2.0, end: 15.0).animate(controller));

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

class _ElapsedTimeLabel extends HookWidget {
  final ValueNotifier<bool> recording;
  const _ElapsedTimeLabel(this.recording, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration = useStopwatch(recording);
    // final tickerProvider = useSingleTickerProvider();
    // final duration = useState(Duration.zero);
    // final ticker = useMemoized(() {
    //   return tickerProvider.createTicker((elapsed) => duration.value = elapsed);
    // });

    // useEffect(() {
    //   recording.value ? ticker.start() : ticker.stop();
    // }, [recording.value]);

    // useEffect(() => () => ticker.dispose(), []);

    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: recording.value,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(duration.value.toString().substring(2, 10)),
      ),
    );
  }
}
