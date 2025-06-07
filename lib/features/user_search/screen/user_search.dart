import 'package:flutter/material.dart';
import 'package:octo_search/data/api/github_api_service.dart';
import 'package:octo_search/data/models/user_search.dart';
import 'package:octo_search/core/widgets/expressive_list_tile.dart';
import 'package:octo_search/core/widgets/search_input.dart';

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
  List<UserSearchItem> _users = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasSearched = false;

  Future<void> _fetchUsers() async {
    final query = _searchTextController.text.trim();
    if (query.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await GitHubApiService.searchUsers(query);
      setState(() {
        _users = result.items;
        _hasSearched = true;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = "Failed to fetch users:\n$error";
        _isLoading = false;
        _hasSearched = true;
      });
    }
  }

  void _clearSearch() {
    setState(() {
      _users = [];
      _errorMessage = null;
      _hasSearched = false;
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('OctoSearch'),
      ),
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
                controller: _searchTextController,
                onSubmitted: (_) => _fetchUsers(),
                hintText: 'Search GitHub Users',
                onClear: _clearSearch,
              ),
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            CircularProgressIndicator(),
            Text('Searching for users...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              onPressed: _fetchUsers,
            ),
          ],
        ),
      );
    }

    if (_users.isEmpty) {
      if (_hasSearched) {
        // Empty search results
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Icon(
                Icons.person_off_outlined,
                size: 64,
              ),
              Text('No users found matching your search'),
            ],
          ),
        );
      } else {
        // Initial state - no search performed yet
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Icon(
                Icons.search,
                size: 64,
              ),
              Text(
                'Enter a name to search for users',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
    }

    return _buildUserList();
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];

        return ExpressiveListTile(
          isFirst: index == 0,
          isLast: index == _users.length - 1,
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
            print('Tapped on user: ${user.login}');
          },
        );
      },
    );
  }
}
