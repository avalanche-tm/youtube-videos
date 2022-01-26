import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ValueNotifier<Duration> useStopwatch(ValueNotifier<bool> start) {
  final tickerProvider = useSingleTickerProvider();
  final duration = useState(Duration.zero);
  final ticker = useMemoized(() {
    return tickerProvider.createTicker((elapsed) => duration.value = elapsed);
  });

  useEffect(() {
    start.value ? ticker.start() : ticker.stop();
  }, [start.value]);

  useEffect(() => () => ticker.dispose(), []);
  return duration;
}
