import 'package:flutter/material.dart';

/// A customized search input field widget.
///
/// This widget provides a [TextField] tailored for search functionality.
/// It includes a search icon as a prefix and a clear button as a suffix
/// that appears when text is entered. It also handles submission and clearing of the search query.
class SearchInput extends StatefulWidget {
  /// The hint text to display when the input field is empty.
  final String hintText;

  /// The [TextEditingController] for managing the text in the input field.
  final TextEditingController controller;

  /// A callback function that is invoked when the user submits the search query
  /// (e.g., by pressing the search button on the keyboard).
  final ValueChanged<String> onSubmitted;

  /// A callback function that is invoked when the user taps the clear button.
  final VoidCallback onClear;

  const SearchInput({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onSubmitted,
    required this.onClear,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  /// Indicates whether the input field currently contains text.
  bool _hasText = false;

  /// Initializes the state and adds a listener to the [TextEditingController] to track text changes.
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    // Initialize _hasText based on the controller's initial text
    _hasText = widget.controller.text.isNotEmpty;
  }

  /// Disposes the state and removes the listener from the [TextEditingController].
  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  /// Called when the text in the [TextEditingController] changes.
  ///
  /// Updates the [_hasText] state if the presence of text has changed,
  /// to control the visibility of the clear button.
  void _onTextChanged() {
    final hasText = widget.controller.text.isNotEmpty;
    // Only update state if the text presence has changed to avoid unnecessary rebuilds.
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(
          Icons.search,
          semanticLabel: 'Search',
        ),
        suffixIcon: _buildClearButton(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  /// Builds the clear button widget that appears as a suffix icon.
  ///
  /// Returns an [IconButton] with a clear icon if [_hasText] is true,
  /// otherwise returns null (no button).
  Widget? _buildClearButton() {
    if (!_hasText) {
      return null;
    }

    return IconButton(
      icon: const Icon(
        Icons.clear_rounded,
        size: 18,
        semanticLabel: 'Clear search',
      ),
      onPressed: () {
        widget.controller.clear();
        widget.onClear();
      },
    );
  }
}
