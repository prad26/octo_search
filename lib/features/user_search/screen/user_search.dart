import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:octo_search/core/widgets/infinite_scroll_list.dart';
import 'package:octo_search/core/widgets/scroll_top_floating_button.dart';
import 'package:octo_search/data/api/github_api_service.dart';
import 'package:octo_search/data/models/user_search.dart';
import 'package:octo_search/core/widgets/expressive_list_tile.dart';
import 'package:octo_search/core/widgets/search_input.dart';
import 'package:octo_search/features/user_profile/screen/user_profile.dart';

/// Screen for searching GitHub users.
///
/// This screen provides a search interface that allows users to query
/// GitHub's user database and displays search results in a list.
/// Each result shows their name, account type with their avatar.
///
/// The screen handles different states:
/// - Initial empty state
/// - Loading state while fetching results
/// - Error state if the search fails
/// - Empty results state when no users match the query
/// - Results list when users are found
class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  static const _pageSize = GitHubApiService.defaultPerPage;

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

  Future<List<UserSearchItem>> _getUsers(int page) async {
    final query = _searchTextController.text.trim();
    if (query.isEmpty) {
      return [];
    }

    final result = await GitHubApiService.getUsers(
      query,
      page: page,
      perPage: _pageSize,
    );

    return result.items;
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _pagingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('OctoSearch'),
      ),
      floatingActionButton: ScrollTopFloatingButton(controller: _scrollController),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
          ),
          child: Column(
            spacing: 12,
            children: [
              SearchInput(
                hintText: 'Search GitHub Users',
                controller: _searchTextController,
                onSubmitted: (_) => _pagingController.refresh(),
                onClear: () => _pagingController.refresh(),
              ),
              Expanded(
                child: _buildUserList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return InfiniteScrollList(
      itemName: 'users',
      controller: _pagingController,
      scrollController: _scrollController,
      fetchPage: _getUsers,
      itemBuilder: (context, index, user, itemsLength) {
        return ExpressiveListTile(
          isFirst: index == 0,
          isLast: index == itemsLength - 1,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(user.avatarUrl),
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
