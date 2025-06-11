import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:octo_search/core/helpers/helpers.dart';
import 'package:octo_search/core/widgets/widgets.dart';
import 'package:octo_search/data/models/repository_search.dart';

/// A widget that displays statistics for a GitHub repository.
/// It shows the number of stars, forks, open issues, and the programming language used.
class RepositoryStats extends StatelessWidget {
  /// The repository item containing the statistics to display.
  final RepositoryItem repo;

  /// A [NumberFormat] instance for formatting numbers (e.g., star counts, fork counts).
  final NumberFormat numberFormat;

  const RepositoryStats({
    super.key,
    required this.repo,
    required this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    final languageColor = getColorForLanguage(repo.language);

    return Row(
      children: [
        Icon(Icons.star_rounded, size: 16, color: Colors.amber.shade700),
        const SizedBox(width: 2),
        Text(numberFormat.format(repo.stargazersCount)),

        const SizedBox(width: 8),

        Icon(Icons.call_split_rounded, size: 16, color: Colors.blue),
        const SizedBox(width: 2),
        Text(numberFormat.format(repo.forksCount)),

        const SizedBox(width: 8),

        Text(
          '!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red.shade700,
          ),
        ),
        const SizedBox(width: 4),
        Text(numberFormat.format(repo.openIssuesCount)),

        if (repo.language != null) ...[
          const SizedBox(width: 8),
          ContainerChip(
            icon: Icons.code_rounded,
            label: repo.language!,
            color: languageColor,
          ),
        ],
      ],
    );
  }
}
