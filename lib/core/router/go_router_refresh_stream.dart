import 'dart:async';
import 'package:flutter/foundation.dart';

/// Adapts any [Stream] to a [Listenable] so go_router's `refreshListenable`
/// can react to bloc state changes (here, [AuthBloc].stream).
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
