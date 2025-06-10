import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:octo_search/core/helpers/index.dart';
import 'package:octo_search/data/api/index.dart';

/// A dialog that prompts the user to enter a GitHub Personal Access Token.
///
/// This dialog is typically shown when API rate limits are reached for unauthenticated requests,
/// requiring an authenticated token to continue.
/// It allows the user to input their token and provides a link to the GitHub token creation page.
class AccessTokenDialog extends StatefulWidget {
  const AccessTokenDialog({super.key});

  /// Shows the [AccessTokenDialog] and returns a [Future] that completes with `true` if a
  /// token was successfully saved, and `false` otherwise (e.g., if the dialog was dismissed).
  ///
  /// [context] is the [BuildContext] used to display the dialog.
  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AccessTokenDialog(),
        ) ??
        false;
  }

  @override
  State<AccessTokenDialog> createState() => _AccessTokenDialogState();
}

class _AccessTokenDialogState extends State<AccessTokenDialog> {
  /// Controls the text input field for the GitHub token.
  final TextEditingController _tokenTextController = TextEditingController();

  /// Indicates whether a token-saving operation is in progress.
  bool _isLoading = false;

  /// Stores an error message to display to the user, if any.
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    GitHubApiService.clearAccessToken(); // Clear any existing token.
  }

  @override
  void dispose() {
    _tokenTextController.dispose();
    super.dispose();
  }

  /// Attempts to save the entered GitHub personal access token.
  ///
  /// Validates the token, updates the UI to show a loading state,
  /// calls [GitHubApiService.setAccessToken], and then closes the dialog
  /// with `true` on success or shows an error message on failure.
  Future<void> _saveToken() async {
    final token = _tokenTextController.text.trim();

    if (token.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a valid token';
      });

      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await GitHubApiService.setAccessToken(token);

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error saving token';
          _isLoading = false;
        });
      }
    }
  }

  /// Opens the GitHub page for creating personal access tokens in a web browser.
  void _openTokenCreationPage() {
    openLink(context, 'https://github.com/settings/personal-access-tokens');
  }

  /// Builds the UI for the [AccessTokenDialog].
  ///
  /// Includes a title, descriptive text, a link to create a token, a [TextField] for token input,
  /// and action buttons for "Cancel" and "Save Token".
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('GitHub API Rate Limit Reached'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          const Text(
            'You\'ve reached the GitHub API rate limit for anonymous requests. '
            'To continue using the app, please provide a personal access token.',
          ),
          RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium,
              children: [
                const TextSpan(
                  text:
                      'To create a token, go to GitHub → Settings → Developer settings → Personal access tokens → Fine-grained tokens. Or, ',
                ),
                TextSpan(
                  text: 'click here to open the page',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _openTokenCreationPage,
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
          TextField(
            controller: _tokenTextController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Personal Access Token',
              errorText: _errorMessage,
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) {
              // Clear error message on change
              if (_errorMessage != null) {
                setState(() {
                  _errorMessage = null;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveToken,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (_isLoading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              const Text('Save Token'),
            ],
          ),
        ),
      ],
    );
  }
}
