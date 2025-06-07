import 'package:flutter/material.dart';

/// A reusable widget for displaying empty state messages.
///
/// This widget shows an icon and a message to indicate that no data is available.
class NoData extends StatelessWidget {
  final String message;
  final IconData? icon;

  const NoData({
    super.key,
    required this.message,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Icon(
            icon ?? Icons.person_off_outlined,
            size: 64,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
