import 'package:flutter/material.dart';

/// A search input field.
///
/// This widget provides a customized text field specifically designed for search
/// functionality, featuring a search icon and a clear button that appears when
/// text is entered.
class SearchInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  const SearchInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
    required this.onClear,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

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
