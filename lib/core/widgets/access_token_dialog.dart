import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:octo_search/core/helpers/url_launcher.dart';
import 'package:octo_search/data/api/github_api_service.dart';

/// A dialog that prompts the user to enter a GitHub Personal Access Token.
///
/// This dialog is typically shown when API rate limits are reached for anonymous
/// requests, requiring an authenticated token to continue.
class AccessTokenDialog extends StatefulWidget {
  const AccessTokenDialog({super.key});

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
  final TextEditingController _tokenTextController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _tokenTextController.dispose();
    super.dispose();
  }

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

  void _openTokenCreationPage() {
    openLink(context, 'https://github.com/settings/personal-access-tokens');
  }

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
