import 'package:flutter/material.dart';

/// A reusable loading indicator widget.
///
/// This widget displays a centered loading spinner with an optional message.
class Loading extends StatelessWidget {
  final String? message;

  const Loading({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          CircularProgressIndicator(),
          if (message != null)
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
        ],
      ),
    );
  }
}
