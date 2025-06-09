import 'dart:async';
import 'package:flutter/material.dart';

/// A simple debouncer class that delays the execution of a function
/// until after a specified duration has passed since the last call.
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    // Cancel the previous timer if it's still active
    _timer?.cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
