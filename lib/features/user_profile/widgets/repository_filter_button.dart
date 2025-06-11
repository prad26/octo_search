import 'package:flutter/material.dart';
import 'package:octo_search/core/enums/repository_filters.dart';

/// A button that displays a dropdown menu for selecting repository filters.
/// The button shows the currently selected filter and allows the user to change it.
/// The available filters are defined in the [RepositoryFilters] enum.
class RepositoryFilterButton extends StatelessWidget {
  /// The currently selected filter to display on the button.
  final RepositoryFilters selectedFilter;

  /// Callback function that is called when the user selects a different filter.
  final ValueChanged<RepositoryFilters> onChange;

  const RepositoryFilterButton({
    super.key,
    required this.selectedFilter,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return ElevatedButton.icon(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.filter_alt_rounded),
          label: Row(
            spacing: 4,
            children: [
              Text(selectedFilter.label),
              Icon(
                controller.isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                size: 20,
              ),
            ],
          ),
        );
      },
      menuChildren: RepositoryFilters.values.map(
        (filter) {
          return MenuItemButton(
            onPressed: () => onChange(filter),
            child: Text(filter.label),
          );
        },
      ).toList(),
    );
  }
}
