import 'dart:async';
import 'package:flutter/material.dart';

/// A simple debouncer class that delays the execution of a function until after a
/// specified duration has passed since the last invocation.
///
/// This is useful for scenarios where an action should only be performed after
/// a period of inactivity, such as when a user stops typing in a search field.
class Debouncer {
  /// The duration in milliseconds to wait before executing the action.
  final int milliseconds;

  /// The internal [Timer] used to manage the delay.
  Timer? _timer;

  Debouncer({required this.milliseconds});

  /// Executes the given [action] after the specified [milliseconds] delay.
  ///
  /// If [run] is called again before the delay has elapsed, the previous
  /// timer is cancelled, and a new timer is started.
  void run(VoidCallback action) {
    _timer?.cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Cancels the internal timer, if it is active.
  ///
  /// This should be called when the [Debouncer] is no longer needed,
  /// for example, in the `dispose` method of a StatefulWidget, to prevent memory leaks.
  void dispose() {
    _timer?.cancel();
  }
}
