import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:octo_search/core/enums/repository_filters.dart';
import 'package:octo_search/core/helpers/helpers.dart';
import 'package:octo_search/core/widgets/widgets.dart';
import 'package:octo_search/data/api/api.dart';
import 'package:octo_search/data/models/repository_search.dart';
import 'package:octo_search/features/user_profile/widgets/repository_filter_button.dart';
import 'package:octo_search/features/user_profile/widgets/repository_stats.dart';

/// A widget that displays a filterable, paginated list of repositories for a GitHub user.
///
/// This widget fetches and shows a list of repositories owned by the specified [username].
/// It includes a filter dropdown to switch between viewing all, non-forked, or forked repositories.
/// The list supports infinite scrolling and handles loading, error, and empty states.
class RepositoryList extends StatefulWidget {
  /// The GitHub username whose repositories are to be displayed.
  final String username;

  /// A [NumberFormat] instance for formatting numbers (e.g., repository counts, stars).
  final NumberFormat numberFormat;

  /// The [ScrollController] to be used by the underlying [InfiniteScrollList]
  /// and potentially by a [ScrollTopFloatingButton] in the parent screen.
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
  /// The currently selected filter for displaying repositories.
  /// Defaults to [RepositoryFilters.nonForked].
  RepositoryFilters _selectedFilter = RepositoryFilters.nonForked;

  /// The total count of repositories matching the current filter.
  /// Null until the first page of data is fetched.
  int? _repoCount;

  /// The number of repositories to fetch per page.
  static const _pageSize = GitHubApiService.defaultPerPage;

  /// The controller for managing pagination of repository items.
  ///
  /// It defines how to get the next page key and how to fetch a page of repositories.
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

  /// Fetches a page of repositories from the GitHub API based on the current
  /// [widget.username], [_selectedFilter], and the given [page] number.
  ///
  /// Uses [GitHubApiHandler.execute] for error management.
  /// Updates [_repoCount] with the total count from the API response.
  /// Returns a [List<RepositoryItem>] for the current page.
  Future<List<RepositoryItem>> _getRepositories(int page) async {
    final repositories = await GitHubApiHandler.execute(
      context: context,
      apiCall: () async {
        final result = await GitHubApiService.getRepositories(
          widget.username,
          filter: _selectedFilter,
          page: page,
          perPage: _pageSize,
        );

        setState(() {
          _repoCount = result.totalCount;
        });

        return result.items;
      },
    );

    return repositories ?? [];
  }

  /// Opens the given [url] in an external browser or app.
  ///
  /// Uses the [openLink] utility function from core helpers.
  void _openLink(String url) {
    openLink(context, url);
  }

  /// Updates the repository filter and refreshes the list.
  ///
  /// If the new [filter] is the same as the current [_selectedFilter], no action is taken.
  /// Otherwise, updates [_selectedFilter], resets [_repoCount], and calls
  /// `refresh()` on the [_pagingController] to load data with the new filter.
  void _updateFilter(RepositoryFilters filter) {
    if (_selectedFilter == filter) return;

    setState(() {
      _selectedFilter = filter;
      _repoCount = null;
    });

    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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

  /// Builds the header section for the repository list.
  ///
  /// Displays the title "Repositories", a [Badge] with the total count ([_repoCount]),
  /// and a [MenuAnchor] button to select the repository filter.
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

        RepositoryFilterButton(
          selectedFilter: _selectedFilter,
          onChange: _updateFilter,
        ),
      ],
    );
  }

  /// Builds the infinitely scrolling list of repositories.
  ///
  /// Uses the [InfiniteScrollList] widget, providing it with the [_pagingController],
  /// [widget.scrollController], [_getRepositories] fetch function, and an itemBuilder
  /// to render each [RepositoryItem] using an [ExpressiveListTile].
  Widget _buildRepoList() {
    return InfiniteScrollList(
      itemName: 'repositories',
      controller: _pagingController,
      scrollController: widget.scrollController,
      fetchPage: _getRepositories,
      itemBuilder: (context, index, repo, itemsLength) {
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
              RepositoryStats(
                repo: repo,
                numberFormat: widget.numberFormat,
              ),
            ],
          ),
          onTap: () => _openLink(repo.htmlUrl),
        );
      },
    );
  }
}
