import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:octo_search/core/enums/repository_filters.dart';
import 'package:octo_search/core/helpers/get_language_color.dart';
import 'package:octo_search/core/helpers/github_error_handler.dart';
import 'package:octo_search/core/helpers/url_launcher.dart';
import 'package:octo_search/core/widgets/container_chip.dart';
import 'package:octo_search/core/widgets/expressive_list_tile.dart';
import 'package:octo_search/core/widgets/infinite_scroll_list.dart';
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
  final ScrollController scrollController;

  const RepositoryList({
    super.key,
    required this.username,
    required this.numberFormat,
    required this.scrollController,
  });

  @override
  State<RepositoryList> createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  RepositoryFilters _selectedFilter = RepositoryFilters.nonForked;
  int? _repoCount;
  static const _pageSize = GitHubApiService.defaultPerPage;

  late final PagingController<int, RepositoryItem> _pagingController = PagingController(
    getNextPageKey: (state) {
      final lastPage = state.pages?.lastOrNull;
      final isLastPageLessThanPageSize = lastPage != null && lastPage.length < _pageSize;
      if (isLastPageLessThanPageSize || state.lastPageIsEmpty) {
        // If the last page has fewer items than the page size, it means there are no more pages.
        return null;
      }

      return state.nextIntPageKey;
    },
    fetchPage: (pageKey) => _getRepositories(pageKey),
  );

  Future<List<RepositoryItem>> _getRepositories(int page) async {
    return GitHubErrorHandler.handleApiError(
      context: context,
      apiCall: () async {
        final result = await GitHubApiService.getRepositories(
          widget.username,
          filter: _selectedFilter,
          page: page,
          perPage: _pageSize,
        );

        return result.items;
      },
    );
  }

  void _openLink(String url) {
    openLink(context, url);
  }

  void _updateFilter(RepositoryFilters filter) {
    if (_selectedFilter == filter) return;

    setState(() {
      _selectedFilter = filter;
      _repoCount = null;
    });

    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        _buildHeader(),
        Expanded(
          child: _buildRepoList(),
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

  Widget _buildRepoList() {
    return InfiniteScrollList(
      itemName: 'repositories',
      controller: _pagingController,
      scrollController: widget.scrollController,
      fetchPage: _getRepositories,
      itemBuilder: (context, index, repo, itemsLength) {
        final languageColor = getColorForLanguage(repo.language);

        return ExpressiveListTile(
          isFirst: index == 0,
          isLast: index == itemsLength - 1,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Expanded(
                child: Text(
                  repo.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
