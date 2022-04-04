import 'package:flutter/foundation.dart';

abstract class Store<T> {
  late final ValueNotifier<T> _notifier;
  late T _prevState;

  Store(T initialState) {
    _notifier = ValueNotifier<T>(initialState);
    _prevState = initialState;
  }

  ValueNotifier<T> get notifier => _notifier;
  T get state => _notifier.value;

  @protected
  void setState(T newState) {
    _prevState = _notifier.value;
    _notifier.value = newState;
  }

  @protected
  Function() addListener(Function(T newValue, T prevValue) func) {
    funcRef() => func(state, _prevState);
    _notifier.addListener(funcRef);
    debugPrint('Added listener: ${funcRef.hashCode}');
    return funcRef;
  }

  @protected
  void removeListener(Function() funcRef) {
    _notifier.removeListener(funcRef);
    debugPrint('Removed listener: ${funcRef.hashCode}');
  }

  @mustCallSuper
  @protected
  dispose() {
    _notifier.dispose();
    debugPrint('Disposed: ${toString()}');
  }
}
