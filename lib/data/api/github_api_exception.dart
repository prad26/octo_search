import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_api_exception.freezed.dart';

/// Represents an exception that occurs during interaction with the GitHub API.
///
/// This class uses `freezed` to define a sealed hierarchy of specific GitHub API error types.
/// Use the [GitHubException.from] factory to create an appropriate exception instance
/// based on HTTP status codes and response bodies.
@freezed
sealed class GitHubException with _$GitHubException {
  const GitHubException._();

  /// Creates a [GitHubException] based on the HTTP status code and response body.
  ///
  /// This factory attempts to map common HTTP error codes to specific
  /// [GitHubException] subtypes.
  factory GitHubException.from({
    int? statusCode,
    String? responseBody,
  }) {
    if (statusCode == 401) {
      return const GitHubException.unauthorized();
    } else if (statusCode == 403 && responseBody != null && responseBody.toLowerCase().contains('rate limit')) {
      return const GitHubException.rateLimitExceeded();
    } else if (statusCode == 403) {
      return const GitHubException.forbidden();
    } else if (statusCode == 404) {
      return const GitHubException.notFound();
    } else if (statusCode == 422) {
      return const GitHubException.validation();
    } else if (statusCode.toString().startsWith('5')) {
      return const GitHubException.server();
    } else {
      return const GitHubException.generic();
    }
  }

  const factory GitHubException.unauthorized() = GitHubUnauthorizedException;
  const factory GitHubException.forbidden() = GitHubForbiddenException;
  const factory GitHubException.notFound() = GitHubNotFoundException;
  const factory GitHubException.validation() = GitHubValidationException;
  const factory GitHubException.server() = GitHubServerException;
  const factory GitHubException.rateLimitExceeded() = GitHubRateLimitExceeded;
  const factory GitHubException.generic() = GitHubGenericException;
  const factory GitHubException.parsing() = GitHubParsingException;

  /// Provides a user-friendly error message for each exception type.
  String get errorMessage {
    return switch (this) {
      GitHubUnauthorizedException() => 'Unauthorized access. Please check your credentials.',
      GitHubForbiddenException() => 'Access forbidden. You do not have permission to perform this action.',
      GitHubNotFoundException() => 'Resource not found.',
      GitHubValidationException() => 'Validation error.',
      GitHubServerException() => 'Server error. Please try again later.',
      GitHubRateLimitExceeded() => 'Rate limit exceeded.',
      GitHubGenericException() => 'An unexpected error occurred. Please try again later.',
      GitHubParsingException() => 'Error parsing the response from the server.',
    };
  }

  @override
  String toString() => '$runtimeType: $errorMessage';
}
