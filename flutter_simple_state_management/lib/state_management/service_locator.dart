library service_locator;

abstract class ServiceLocator {
  static final _instances = <String, dynamic>{};
  static final _constructors = <String, Function()>{};

  static void register<T>(T Function() creator, {bool lazy = false}) {
    final type = T.toString();
    // _instances.putIfAbsent(type, () => creator);
    _constructors[type] = creator;
    if (!lazy) {
      _instances[type] = creator();
    }
    // _constructors.putIfAbsent(type, () => creator);
  }

  static T get<T>() {
    final type = T.toString();
    if (_instances[type] == null) {
      _instances[type] = _constructors[type]!();
    }
    // if (_instances[type] is Function) {
    //   _instances[type] = _instances[type]();
    // }
    return _instances[type] as T;
  }

  static void reset<T>(Function(T) beforeRemove) {
    final type = T.toString();
    // (_instances[type] as dynamic).dispose();
    beforeRemove(_instances[type]);
    _instances[type] = _constructors[type]!();
  }

  static void unregister<T>(Function(T) beforeRemove) {
    final type = T.toString();
    beforeRemove(_instances[type]);
    _instances.removeWhere((key, value) => key == type);
    _constructors.removeWhere((key, value) => key == type);
  }
}
