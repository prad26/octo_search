import 'package:flutter/material.dart';

/// A reusable widget for displaying error messages.
///
/// This widget shows an error icon, a [message], and an optional retry button
/// if an [onRetry] callback is provided.
class ErrorMessage extends StatelessWidget {
  /// The error message to display.
  final String message;

  /// An optional callback that is invoked when the retry button is pressed.
  /// If null, the retry button is not shown.
  final VoidCallback? onRetry;

  const ErrorMessage({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: errorColor,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: errorColor,
            ),
          ),
          if (onRetry != null)
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              onPressed: onRetry,
            ),
        ],
      ),
    );
  }
}
