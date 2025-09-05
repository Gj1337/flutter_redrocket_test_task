import 'dart:async';
import 'package:flutter/foundation.dart';

class StreamListenable<T> extends ChangeNotifier {
  late final StreamSubscription<T> _subscription;

  StreamListenable(Stream<T> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
