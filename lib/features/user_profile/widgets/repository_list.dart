import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:octo_search/core/enums/repository_filters.dart';
import 'package:octo_search/core/helpers/get_language_color.dart';
import 'package:octo_search/core/helpers/url_launcher.dart';
import 'package:octo_search/core/widgets/container_chip.dart';
import 'package:octo_search/core/widgets/error_message.dart';
import 'package:octo_search/core/widgets/expressive_list_tile.dart';
import 'package:octo_search/core/widgets/loading.dart';
import 'package:octo_search/core/widgets/no_data.dart';
import 'package:octo_search/data/api/github_api_service.dart';
import 'package:octo_search/data/models/repository_search.dart';

/// A widget that displays a filterable list of repositories for a GitHub user.
///
/// This widget shows a list of repositories owned by the specified user,
/// with options to filter by repository type (all, non-forked, forked).
/// It handles loading, error, and empty states appropriately.
class RepositoryList extends StatefulWidget {
  final String username;
  final NumberFormat numberFormat;

  const RepositoryList({
    super.key,
    required this.username,
    required this.numberFormat,
  });

  @override
  State<RepositoryList> createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  RepositoryFilters _selectedFilter = RepositoryFilters.nonForked;
  int? _repoCount;
  String? _errorMessage;
  bool _isLoading = true;
  List<RepositoryItem> _repositories = [];

  Future<void> _fetchRepos() async {
    setState(() {
      _repoCount = null;
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await GitHubApiService.getRepositories(
        widget.username,
        filter: _selectedFilter,
      );
      setState(() {
        _repositories = result.items;
        _repoCount = result.totalCount;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = "Failed to load user:\n$error";
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRepos();
  }

  void _openLink(String url) {
    openLink(context, url);
  }

  void _updateFilter(RepositoryFilters filter) {
    if (_selectedFilter == filter) return;

    setState(() {
      _selectedFilter = filter;
    });

    _fetchRepos();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        _buildHeader(),
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4,
          children: [
            Text(
              'Repositories',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            if (_repoCount != null)
              Badge(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                textColor: Theme.of(context).colorScheme.secondary,
                label: Text(widget.numberFormat.format(_repoCount)),
              ),
          ],
        ),

        MenuAnchor(
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
                  Text(_selectedFilter.label),
                  Icon(
                    controller.isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    size: 20,
                  ),
                ],
              ),
            );
          },
          menuChildren: RepositoryFilters.values.map((filter) {
            return MenuItemButton(
              onPressed: () => _updateFilter(filter),
              child: Text(filter.label),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Loading(
        message: 'Loading repositories...',
      );
    }

    if (_errorMessage != null) {
      return ErrorMessage(
        message: _errorMessage!,
        onRetry: _fetchRepos,
      );
    }

    if (_repositories.isEmpty) {
      return NoData(message: 'No repositories found for');
    }

    return _buildRepoList();
  }

  Widget _buildRepoList() {
    return ListView.builder(
      itemCount: _repositories.length,
      itemBuilder: (context, index) {
        final repo = _repositories[index];
        final languageColor = getColorForLanguage(repo.language);

        return ExpressiveListTile(
          isFirst: index == 0,
          isLast: index == _repositories.length - 1,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                repo.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (repo.fork)
                ContainerChip(
                  icon: Icons.call_split_rounded,
                  label: 'Fork',
                  color: Colors.blue,
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              if (repo.description != null) Text(repo.description!),
              _buildRepoStats(repo, languageColor),
            ],
          ),
          onTap: () => _openLink(repo.htmlUrl),
        );
      },
    );
  }

  Row _buildRepoStats(RepositoryItem repo, Color languageColor) {
    return Row(
      children: [
        Icon(Icons.star_rounded, size: 16, color: Colors.amber.shade700),
        const SizedBox(width: 2),
        Text(widget.numberFormat.format(repo.stargazersCount)),

        const SizedBox(width: 8),

        Icon(Icons.call_split_rounded, size: 16, color: Colors.blue),
        const SizedBox(width: 2),
        Text(widget.numberFormat.format(repo.forksCount)),

        const SizedBox(width: 8),

        Text(
          '!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red.shade700,
          ),
        ),
        const SizedBox(width: 4),
        Text(widget.numberFormat.format(repo.openIssuesCount)),

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
