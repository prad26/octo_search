import 'package:flutter/material.dart';

/// Displays a [SnackBar] with an error message and an optional retry action.
///
/// The [SnackBar] is styled with the error colors from the current theme.
/// If an [onRetry] callback is provided, a "Retry" button will be shown.
///
/// [context] is the [BuildContext] used to show the [SnackBar].
/// [message] is the error message to display.
/// [onRetry] is an optional [VoidCallback] that is executed when the "Retry"
/// button is pressed.
void showErrorSnackBar({
  required BuildContext context,
  required String message,
  VoidCallback? onRetry,
}) {
  if (!context.mounted) return;

  final colorScheme = Theme.of(context).colorScheme;
  final messenger = ScaffoldMessenger.of(context);

  // Hide any existing snack bars to prevent queuing
  messenger.hideCurrentSnackBar();

  messenger.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: colorScheme.onError),
      ),
      backgroundColor: colorScheme.error,
      duration: const Duration(seconds: 3),
      action: onRetry != null
          ? SnackBarAction(
              label: 'Retry',
              textColor: colorScheme.onError,
              onPressed: onRetry,
            )
          : null,
    ),
  );
}
