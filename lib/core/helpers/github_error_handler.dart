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
      if (e is! GitHubUnauthorizedException && e is! GitHubForbiddenException && e is! GitHubRateLimitExceeded) {
        if (onError != null) {
          onError();
        }

        rethrow;
      }

      final tokenAdded = await _showAccessTokenDialog(context);

      if (tokenAdded) {
        return await apiCall();
      } else {
        throw GitHubGenericException();
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
