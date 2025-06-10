import 'package:flutter/material.dart';

/// A [FloatingActionButton] that appears when the user scrolls down a list
/// beyond a certain threshold, allowing them to quickly scroll back to the top.
///
/// The button's visibility is tied to the scroll offset of the provided [ScrollController].
class ScrollTopFloatingButton extends StatefulWidget {
  /// The [ScrollController] that this button listens to for scroll changes.
  final ScrollController controller;

  /// The scroll offset (in pixels) after which the button becomes visible.
  /// Defaults to 300 pixels.
  final int scrollThreshold;

  const ScrollTopFloatingButton({
    super.key,
    required this.controller,
    this.scrollThreshold = 300,
  });

  @override
  State<ScrollTopFloatingButton> createState() => _ScrollTopFloatingButtonState();
}

class _ScrollTopFloatingButtonState extends State<ScrollTopFloatingButton> {
  /// Whether the floating action button is currently visible.
  bool _isVisible = false;

  /// Initializes the state and adds a listener to the [ScrollController].
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
  }

  /// Disposes the state and removes the listener from the [ScrollController].
  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  /// Listens to scroll events and updates the visibility of the button.
  ///
  /// The button becomes visible if the scroll offset exceeds [widget.scrollThreshold]
  /// and hides if it falls below that threshold.
  void _scrollListener() {
    if (widget.controller.offset >= widget.scrollThreshold && !_isVisible) {
      setState(() {
        _isVisible = true;
      });
    } else if (widget.controller.offset < widget.scrollThreshold && _isVisible) {
      setState(() {
        _isVisible = false;
      });
    }
  }

  /// Animates the scroll position back to the top of the list (offset 0).
  void _scrollToTop() {
    widget.controller.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    return FloatingActionButton(
      onPressed: _scrollToTop,
      tooltip: 'Scroll to Top',
      mini: true,
      child: const Icon(Icons.arrow_upward_rounded),
    );
  }
}
