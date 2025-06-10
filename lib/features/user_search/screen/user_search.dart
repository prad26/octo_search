import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:octo_search/core/helpers/debouncer.dart';
import 'package:octo_search/core/widgets/widgets.dart';
import 'package:octo_search/data/api/api.dart';
import 'package:octo_search/data/models/user_search.dart';
import 'package:octo_search/features/user_profile/screen/user_profile.dart';

/// A screen for searching GitHub users.
///
/// This screen provides a search input field to query GitHub's user database.
/// Search results are displayed in a paginated list, showing each user's avatar,
/// login name, and account type. Tapping a user navigates to their profile screen.
///
/// The screen handles various states:
/// - Initial state: Prompts the user to start searching.
/// - Loading state: While fetching search results.
/// - Error state: If the search API call fails.
/// - Empty results state: When no users match the search query.
/// - Results list: When users are found.
class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  /// Controls the text input for the search query.
  final TextEditingController _searchTextController = TextEditingController();

  /// The [ScrollController] for the list of search results, used by the
  /// [ScrollTopFloatingButton] and the [InfiniteScrollList].
  final ScrollController _scrollController = ScrollController();

  /// The number of users to fetch per page.
  static const _pageSize = GitHubApiService.defaultPerPage;

  /// A flag indicating whether a search has been performed at least once.
  /// Used to differentiate between the initial empty state and an empty search result.
  bool _hasSearched = false;

  /// A [Debouncer] to delay API calls while the user is typing in the search field.
  final Debouncer _debouncer = Debouncer(milliseconds: 300);

  /// The controller for managing pagination of user search results.
  ///
  /// It defines how to get the next page key and how to fetch a page of users.
  late final PagingController<int, UserSearchItem> _pagingController = PagingController(
    getNextPageKey: (state) {
      final lastPage = state.pages?.lastOrNull;
      final isLastPageLessThanPageSize = lastPage != null && lastPage.length < _pageSize;
      if (isLastPageLessThanPageSize || state.lastPageIsEmpty) {
        // If the last page has fewer items than the page size, it means there are no more pages.
        return null;
      }

      return state.nextIntPageKey;
    },
    fetchPage: (pageKey) => _getUsers(pageKey),
  );

  /// Fetches a page of users from the GitHub API based on the current search query.
  ///
  /// If the search query is empty, it resets the [_hasSearched] flag and returns
  /// an empty list. Otherwise, it sets [_hasSearched] to true and makes the API call
  /// using [GitHubApiHandler.execute] for error management.
  ///
  /// [page] The page number to fetch.
  /// Returns a [List<UserSearchItem>] for the current page.
  Future<List<UserSearchItem>> _getUsers(int page) async {
    final query = _searchTextController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _hasSearched = false;
      });

      return [];
    }

    setState(() {
      _hasSearched = true;
    });

    final users = await GitHubApiHandler.execute(
      context: context,
      apiCall: () async {
        final result = await GitHubApiService.getUsers(
          query,
          page: page,
          perPage: _pageSize,
        );

        return result.items;
      },
    );

    return users ?? [];
  }

  /// Initializes the state. Called when this widget is inserted into the tree.
  ///
  /// Sets up a listener on the [_searchTextController] to trigger a debounced
  /// search when the text changes.
  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() {
      _debouncer.run(_pagingController.refresh);
    });
  }

  /// Disposes the state and cleans up controllers and the debouncer.
  ///
  /// Called when this widget is removed from the tree.
  @override
  void dispose() {
    _searchTextController.dispose();
    _pagingController.dispose();
    _scrollController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OctoScaffold(
      scrollController: _scrollController,
      child: Column(
        spacing: 12,
        children: [
          SearchInput(
            hintText: 'Search GitHub Users',
            controller: _searchTextController,
            onSubmitted: (_) => _pagingController.refresh(),
            onClear: _pagingController.refresh,
          ),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  /// Builds the infinitely scrolling list of user search results.
  ///
  /// Uses the [InfiniteScrollList] widget, providing it with the [_pagingController],
  /// [_scrollController], [_getUsers] fetch function, and an itemBuilder
  /// to render each [UserSearchItem] using an [ExpressiveListTile].
  /// It also provides a custom `noItemsFoundIndicatorBuilder` to show a
  /// different message based on whether a search has been performed.
  Widget _buildUserList() {
    return InfiniteScrollList(
      itemName: 'users',
      controller: _pagingController,
      scrollController: _scrollController,
      fetchPage: _getUsers,
      noItemsFoundIndicatorBuilder: _hasSearched
          ? null
          : (context) => NoData(
              message: 'Search for users by name, username...',
              icon: Icons.search_rounded,
            ),
      itemBuilder: (context, index, user, itemsLength) {
        return ExpressiveListTile(
          isFirst: index == 0,
          isLast: index == itemsLength - 1,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          leading: UserAvatar(
            url: user.avatarUrl,
          ),
          title: Text(user.login),
          subtitle: Text(user.type),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(
                  username: user.login,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
