import 'package:flutter/material.dart';

/// Shows an error message in a snack bar with optional retry action.
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
