import 'package:flutter/material.dart';
import 'package:octo_search/core/widgets/index.dart';

/// A custom Scaffold widget for the OctoSearch application.
///
/// This scaffold provides a consistent layout structure, including an AppBar
/// with a title (optionally an `extraTitle`), a centered body with a maximum
/// width of 768 pixels, and a [ScrollTopFloatingButton].
class OctoScaffold extends StatelessWidget {
  /// A [ScrollController] to be used by the [ScrollTopFloatingButton] and
  /// potentially by the [child] content for scroll-to-top functionality.
  final ScrollController scrollController;

  /// The padding to apply to the top of the [child] content within the SafeArea.
  ///
  /// Defaults to 12.0 pixels.
  final double topPadding;

  /// An optional string to append to the default AppBar title "OctoSearch".
  /// If provided, the title will be "OctoSearch: [extraTitle]".
  final String? extraTitle;

  /// The primary content to display in the scaffold's body.
  final Widget child;

  const OctoScaffold({
    super.key,
    required this.scrollController,
    this.extraTitle,
    this.topPadding = 12.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final title = extraTitle != null ? 'OctoSearch: $extraTitle' : 'OctoSearch';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(title),
      ),
      floatingActionButton: ScrollTopFloatingButton(controller: scrollController),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 768),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: topPadding,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
