library store;

import 'package:flutter/foundation.dart';

abstract class Store<T> {
  late final ValueNotifier<T> _notifier;
  late T _prevState;
  // final _subscriptions = [];
  // final _watchList = <Store, Function()>{};
  // final _watchList = <String, Function()>{};

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

  // @protected
  // void watch<K>(Store<K> store, Function(K newValue, K oldValue) func) {
  //   funcRef() => func(store.state, store._prevState);
  //   store.notifier.addListener(() => funcRef());
  //   _watchList.putIfAbsent(store.toString(), () => funcRef);
  //   debugPrint('${toString()} subscribed to ${store.toString()}');
  // }

  // @protected
  // void removeWatch(Store store) {
  //   final listener = _watchList[store];
  //   if (listener != null) {
  //     store.notifier.removeListener(listener);
  //     _watchList.remove(store);
  //     debugPrint(
  //         'Removed listener ${listener.hashCode} from ${store.toString()}');
  //   }
  // }

  // @protected
  // void watch<K>(Store<K> store, Function(K newValue, K oldValue) func) {
  //   funcRef() => func(store.state, store._prevState);
  //   store.notifier.addListener(() => funcRef());
  //   _watchList.putIfAbsent(store, () => funcRef);
  //   debugPrint('Added listener ${funcRef.hashCode} to ${store.toString()}');
  // }

  // @protected
  // void removeWatch(Store store) {
  //   final listener = _watchList[store];
  //   if (listener != null) {
  //     store.notifier.removeListener(listener);
  //     _watchList.remove(store);
  //     debugPrint(
  //         'Removed listener ${listener.hashCode} from ${store.toString()}');
  //   }
  // }

  @protected
  Function() addListener(Function(T newValue, T prevValue) func) {
    funcRef() => func(state, _prevState);
    _notifier.addListener(funcRef);
    // _subscriptions.add(funcRef);
    debugPrint('Added listener: ${funcRef.hashCode}');
    return funcRef;
  }

  @protected
  void removeListener(Function() funcRef) {
    _notifier.removeListener(funcRef);
    // _subscriptions.remove(funcRef);
    debugPrint('Removed listener: ${funcRef.hashCode}');
  }

  @mustCallSuper
  @protected
  dispose() {
    // Map.from(_watchList).forEach((key, value) {
    //   removeWatch(key);
    // });

    // for (var sub in List.from(_subscriptions)) {
    //   removeListener(sub);
    // }
    _notifier.dispose();
    debugPrint('Disposed: ${toString()}');
  }
}
