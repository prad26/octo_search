import 'package:flutter/material.dart';

/// A custom ListTile with expressive rounded corners.
/// Inspired by Material Expressive design.
///
/// Used for creating list items with different corner radii depending on
/// position in a list (first, middle, or last).
class ExpressiveListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final bool isFirst;
  final bool isLast;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const ExpressiveListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.onTap,
    this.isFirst = false,
    this.isLast = false,
    this.padding,
  });

  static double bigRadius = 20.0;
  static double smallRadius = 4.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isFirst ? bigRadius : smallRadius),
          bottom: Radius.circular(isLast ? bigRadius : smallRadius),
        ),
        child: Material(
          color: Theme.of(context).colorScheme.surfaceBright,
          child: ListTile(
            contentPadding: padding,
            leading: leading,
            title: title,
            subtitle: subtitle,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
