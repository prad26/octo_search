import 'package:flutter/material.dart';

/// A floating action button that appears when scrolling down 
/// and allows users to quickly scroll back to the top.
class ScrollTopFloatingButton extends StatefulWidget {
  final ScrollController controller;
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
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

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
