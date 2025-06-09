import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:octo_search/core/helpers/github_error_handler.dart';
import 'package:octo_search/core/helpers/url_launcher.dart';
import 'package:octo_search/core/widgets/error_message.dart';
import 'package:octo_search/core/widgets/loading.dart';
import 'package:octo_search/core/widgets/no_data.dart';
import 'package:octo_search/core/widgets/scroll_top_floating_button.dart';
import 'package:octo_search/core/widgets/user_avatar.dart';
import 'package:octo_search/data/api/github_api_service.dart';
import 'package:octo_search/data/models/user_profile.dart';
import 'package:octo_search/features/user_profile/widgets/repository_list.dart';

/// Screen to display detailed profile information for a GitHub user.
///
/// This screen fetches and displays comprehensive information about a GitHub user,
/// including their profile details, statistics, and contact information.
///
/// It handles different states:
/// - Loading state while fetching the profile
/// - Error state if the fetch fails
/// - Profile display once data is loaded
///
/// The screen also provides interactive elements like clickable links
/// for the user's website, location, company, etc.
class UserProfileScreen extends StatefulWidget {
  final String username;

  const UserProfileScreen({
    super.key,
    required this.username,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isLoading = true;
  UserProfile? _user;
  String? _errorMessage;
  final NumberFormat _numberFormat = NumberFormat.decimalPattern();
  final ScrollController _scrollController = ScrollController();

  void _openLink(String url) {
    openLink(context, url);
  }

  Future<void> _getUserProfile() async {
    GitHubErrorHandler.handleApiError(
      context: context,
      apiCall: () async {
        setState(() {
          _isLoading = true;
          _errorMessage = null;
        });

        final result = await GitHubApiService.getUserProfile(widget.username);

        setState(() {
          _user = result;
          _isLoading = false;
        });
      },
      onError: () {
        setState(() {
          _errorMessage = "Failed to load user: ${widget.username}";
          _isLoading = false;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('OctoSearch: ${widget.username}'),
      ),
      floatingActionButton: ScrollTopFloatingButton(controller: _scrollController),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Loading(
        message: 'Loading user profile...',
      );
    }

    if (_errorMessage != null) {
      return ErrorMessage(
        message: _errorMessage!,
        onRetry: _getUserProfile,
      );
    }

    if (_user == null) {
      return NoData(message: 'No user found for "${widget.username}"');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        const SizedBox.shrink(), // using the spacing property of Column.
        _buildHeader(),
        _buildInfo(),
        Expanded(
          child: RepositoryList(
            username: widget.username,
            numberFormat: _numberFormat,
            scrollController: _scrollController,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final profile = _user!;

    return InkWell(
      onTap: () => _openLink(profile.htmlUrl),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        spacing: 16,
        children: [
          UserAvatar(
            size: 72,
            url: profile.avatarUrl,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name ?? profile.login,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (profile.name != null)
                  Text(
                    '@${profile.login}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                if (profile.bio != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    profile.bio!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    final profile = _user!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          icon: Icons.person_rounded,
          value:
              '${_numberFormat.format(profile.followers)} followers・${_numberFormat.format(profile.following)} following',
        ),
        Row(
          children: [
            _buildInfoRow(
              icon: Icons.location_on_outlined,
              value: profile.location,
              onTap: (value) => _openLink('https://www.google.com/maps/search/?api=1&query=$value'),
            ),

            if (profile.location != null && profile.blog != null) const SizedBox(width: 20),

            _buildInfoRow(
              icon: Icons.calendar_today_outlined,
              value: 'Joined ${DateFormat.yMMMMd().format(profile.createdAt)}',
            ),
          ],
        ),
        _buildInfoRow(
          icon: Icons.business_outlined,
          value: profile.company,
          onTap: (value) {
            if (value.startsWith('@')) {
              _openLink('https://www.github.com/${value.substring(1)}');
            }
          },
        ),
        _buildInfoRow(
          icon: Icons.link_outlined,
          value: profile.blog,
          onTap: (value) => _openLink(value),
        ),
        _buildInfoRow(
          icon: Icons.email_outlined,
          value: profile.email,
          onTap: (value) => _openLink('mailto:$value'),
        ),
      ],
    );
  }

  Widget _buildInfoRow({required IconData icon, String? value, ValueChanged<String>? onTap}) {
    if (value == null || value.isEmpty) {
      return SizedBox.shrink();
    }

    final widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        spacing: 8,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: () => onTap(value),
        borderRadius: BorderRadius.circular(4),
        child: widget,
      );
    } else {
      return widget;
    }
  }
}
