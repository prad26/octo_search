import 'package:flutter/material.dart';
import 'package:octo_search/core/widgets/index.dart';
import 'package:octo_search/data/api/github_api_exception.dart';

/// A helper class to manage certain [GitHubException] types by prompting
/// the user to add an access token.
///
/// When specific API errors occur, this handler shows a dialog to input a GitHub access token. 
/// If a token is successfully added, the original API call can be retried.
class GitHubErrorHandler {
  /// A flag to ensure that only one access token dialog is shown at a time.
  static bool _isShowingDialog = false;

  /// Handles API errors by catching specific [GitHubException] types and prompting the
  /// user to add an access token.
  ///
  /// It attempts to execute [apiCall]. If exceptions such as [GitHubUnauthorizedException],
  /// [GitHubForbiddenException], or [GitHubRateLimitExceeded] are caught, it shows an access token dialog.
  /// If a token is added, [apiCall] is retried. Otherwise, a [GitHubGenericException] is thrown.
  /// For other exceptions, an optional [onError] callback is executed, and the original exception is rethrown.
  ///
  /// [context] is the [BuildContext] used to show the dialog.
  /// [apiCall] is a function that returns a [Future] representing the API call.
  /// [onError] is an optional callback executed for unhandled exceptions.
  /// Returns the result of [apiCall] if successful.
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

  /// Shows a dialog to request the user to add a GitHub access token.
  ///
  /// Prevents showing multiple dialogs simultaneously using [_isShowingDialog].
  /// Returns `true` if a token was added (dialog was confirmed), `false` otherwise.
  ///
  /// [context] is the [BuildContext] used to show the [AccessTokenDialog].
  static Future<bool> _showAccessTokenDialog(BuildContext context) async {
    if (_isShowingDialog) return false;

    _isShowingDialog = true;
    final result = await AccessTokenDialog.show(context);
    _isShowingDialog = false;

    return result;
  }
}
