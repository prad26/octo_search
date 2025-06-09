import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:octo_search/core/helpers/index.dart';
import 'package:octo_search/core/widgets/index.dart';
import 'package:octo_search/data/api/index.dart';
import 'package:octo_search/data/models/user_profile.dart';
import 'package:octo_search/features/user_profile/widgets/repository_list.dart';

/// A screen that displays detailed profile information for a GitHub user.
///
/// This screen fetches and shows comprehensive details about a GitHub user,
/// including their avatar, name, bio, follower/following counts, location,
/// company, blog, email, and join date. It also includes a list of their repositories.
///
/// The screen handles loading and error states during the API call.
/// Interactive elements allow opening links for the user's website, location, company, etc.
class UserProfileScreen extends StatefulWidget {
  /// The GitHub username of the profile to display.
  final String username;

  const UserProfileScreen({
    super.key,
    required this.username,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  /// Indicates whether the user profile data is currently being loaded.
  bool _isLoading = true;

  /// The fetched [UserProfile] data. Null if not yet loaded or if an error occurred.
  UserProfile? _user;

  /// An error message string to display if fetching the profile fails. Null otherwise.
  String? _errorMessage;

  /// A [NumberFormat] instance for formatting numbers (e.g., follower counts).
  final NumberFormat _numberFormat = NumberFormat.decimalPattern();

  /// The [ScrollController] for the main scrollable view, used by the [ScrollTopFloatingButton].
  final ScrollController _scrollController = ScrollController();

  /// Opens the given [url] in an external browser or app.
  ///
  /// Uses the [openLink] utility function.
  void _openLink(String url) {
    openLink(context, url);
  }

  /// Fetches the user profile data from the GitHub API.
  ///
  /// Uses [GitHubErrorHandler.handleApiError] to manage API calls and errors.
  /// Updates [_isLoading], [_user], and [_errorMessage] based on the API response.
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
          _errorMessage = 'Failed to load user: ${widget.username}';
          _isLoading = false;
        });
      },
    );
  }

  /// Initializes the state. Called when this widget is inserted into the tree.
  ///
  /// Triggers the initial fetch of the user profile data.
  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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

  /// Builds the main content of the screen based on the current state.
  ///
  /// Returns a [Loading] widget if [_isLoading] is true.
  /// Returns an [ErrorMessage] widget if [_errorMessage] is not null.
  /// Returns a [NoData] widget if [_user] is null after loading (and no error).
  /// Otherwise, returns a [Column] containing the user's profile header, detailed info, and their repository list.
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

  /// Builds the header section of the user profile.
  ///
  /// Displays the user's avatar, name (or login), login handle, and bio.
  /// The header is tappable and opens the user's GitHub profile URL.
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

  /// Builds the informational section of the user profile.
  ///
  /// Displays details like follower/following counts, location, join date,
  /// company, blog link, and email, each with an appropriate icon.
  /// Some items are tappable to open relevant links.
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

  /// Builds a single row of information for the [_buildInfo] section.
  ///
  /// Each row consists of an [icon] and a [value] (text).
  /// If [value] is null or empty, an empty [SizedBox] is returned.
  /// If an [onTap] callback is provided, the row becomes tappable.
  ///
  /// [icon] The [IconData] to display.
  /// [value] The string value to display. Can be null.
  /// [onTap] An optional callback when the row is tapped, receiving the [value].
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
