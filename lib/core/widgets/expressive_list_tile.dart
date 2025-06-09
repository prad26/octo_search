import 'package:flutter/material.dart';

/// A custom [ListTile] with expressive rounded corners, inspired by Material Expressive design.
///
/// This widget is used for creating list items that can have different corner
/// radii depending on their position within a list (e.g., first, middle, or last).
/// It allows for a more visually distinct list presentation.
class ExpressiveListTile extends StatelessWidget {
  /// An optional widget to display before the [title].
  final Widget? leading;

  /// The primary content of the list tile.
  final Widget? title;

  /// Additional content displayed below the [title].
  final Widget? subtitle;

  /// Whether this tile is the first item in a list.
  ///
  /// If `true`, the top corners will have a [bigRadius]. Otherwise, they will
  /// have a [smallRadius]. Defaults to `false`.
  final bool isFirst;

  /// Whether this tile is the last item in a list.
  ///
  /// If `true`, the bottom corners will have a [bigRadius]. Otherwise, they will
  /// have a [smallRadius]. Defaults to `false`.
  final bool isLast;

  /// An optional callback that is triggered when the tile is tapped.
  final GestureTapCallback? onTap;

  /// The internal padding for the [ListTile]'s content.
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

  /// The larger radius value used for the corners of the first/last tile.
  static double bigRadius = 20.0;

  /// The smaller radius value used for the corners of middle tiles.
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
