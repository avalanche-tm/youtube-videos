import 'package:flutter/foundation.dart';

class DummyApi {
  DummyApi() {
    debugPrint('DummyApi created');
  }
  Future<String> getHttpResource() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => 'HTTP resource has successfully loaded.',
    );
  }
}
