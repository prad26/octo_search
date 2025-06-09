import 'package:flutter/material.dart';
import 'package:octo_search/core/widgets/access_token_dialog.dart';
import 'package:octo_search/data/api/github_api_exception.dart';

/// A helper class to manage specific [GitHubException] types in the presentation layer.
class GitHubErrorHandler {
  static bool _isShowingDialog = false;

  static Future<T> handleApiError<T>({
    required BuildContext context,
    required Future<T> Function() apiCall,
    VoidCallback? onError,
  }) async {
    try {
      return await apiCall();
    } catch (e) {
      switch (e) {
        case GitHubUnauthorizedException():
        case GitHubForbiddenException():
        case GitHubRateLimitExceeded():
          // If e is one of these specific GitHub exceptions, proceed to show the access token dialog.
          final tokenAdded = await _showAccessTokenDialog(context);
          if (tokenAdded) {
            return await apiCall(); // Retry.
          } else {
            // If the dialog was dismissed or failed, throw a generic exception or rethrow e.
            throw GitHubGenericException();
          }

        default:
          // For all other types of exceptions (including other GitHubException subtypes or non-GitHub exceptions),
          // call the onError callback if provided, and then rethrow the original exception.
          if (onError != null) {
            onError();
          }

          rethrow;
      }
    }
  }

  /// Shows a dialog to request the user to add an access token.
  static Future<bool> _showAccessTokenDialog(BuildContext context) async {
    if (_isShowingDialog) return false;

    _isShowingDialog = true;
    final result = await AccessTokenDialog.show(context);
    _isShowingDialog = false;

    return result;
  }
}
