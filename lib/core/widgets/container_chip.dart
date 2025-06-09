import 'package:flutter/material.dart';

/// A custom chip-like widget with customizable icon, label, and colors.
///
/// This widget displays a colored container with an optional icon and text label.
/// It's designed to represent tags, categories, or status indicators.
class ContainerChip extends StatelessWidget {
  /// The optional icon to display before the label.
  final IconData? icon;

  /// The text label to display in the chip.
  final String label;

  /// The optional [TextStyle] for the label.
  /// If null, a default style is used.
  final TextStyle? labelStyle;

  /// The base color for the chip's background and icon (if present).
  /// The background will be a semi-transparent version of this color.
  final Color color;

  const ContainerChip({
    super.key,
    this.icon,
    required this.label,
    this.labelStyle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(36),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 16.0,
              color: color,
            ),
          if (icon != null) const SizedBox(width: 2),
          Text(
            label,
            style:
                labelStyle ??
                TextStyle(
                  fontSize: 12,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}
