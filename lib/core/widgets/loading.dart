import 'package:flutter/material.dart';

/// A reusable loading indicator widget.
///
/// This widget displays a centered [CircularProgressIndicator] with an optional [message] displayed below it.
class Loading extends StatelessWidget {
  /// An optional message to display below the loading spinner.
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
