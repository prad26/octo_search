import 'package:flutter/material.dart';

/// A reusable widget for displaying a message when no data is available.
///
/// This widget shows an [icon] and a [message] to inform the user about
/// an empty state, for example, when a search yields no results.
class NoData extends StatelessWidget {
  /// The message to display, indicating why no data is shown.
  final String message;

  /// The optional icon to display above the message.
  /// If null, [Icons.person_off_outlined] is used by default.
  final IconData icon;

  const NoData({
    super.key,
    required this.message,
    this.icon = Icons.person_off_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Icon(
            icon,
            size: 64,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
