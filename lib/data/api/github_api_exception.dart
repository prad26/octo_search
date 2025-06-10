import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_api_exception.freezed.dart';

/// Represents an exception that occurs during interaction with the GitHub API.
///
/// This class uses `freezed` to define a sealed hierarchy of specific GitHub API error types.
/// Use the [GitHubException.from] factory to create an appropriate exception instance
/// based on HTTP status codes and response bodies.
@freezed
sealed class GitHubException with _$GitHubException implements Exception {
  const GitHubException._();

  /// Creates a [GitHubException] based on the HTTP status code and response body.
  ///
  /// This factory attempts to map common HTTP error codes to specific
  /// [GitHubException] subtypes.
  ///
  /// [statusCode] The HTTP status code from the API response.
  /// [responseBody] The body of the HTTP response, used for more specific
  /// error detection (e.g., distinguishing rate limit errors within a 403 status).
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

  /// Represents an error due to unauthorized access (HTTP 401).
  const factory GitHubException.unauthorized() = GitHubUnauthorizedException;

  /// Represents an error due to forbidden access (HTTP 403), not related to rate limits.
  const factory GitHubException.forbidden() = GitHubForbiddenException;

  /// Represents an error when a resource is not found (HTTP 404).
  const factory GitHubException.notFound() = GitHubNotFoundException;

  /// Represents a validation error, often associated with unprocessable entity (HTTP 422).
  const factory GitHubException.validation() = GitHubValidationException;

  /// Represents a server-side error on GitHub's end (HTTP 5xx).
  const factory GitHubException.server() = GitHubServerException;

  /// Represents an error due to exceeding the API rate limit (HTTP 403 with specific body content).
  const factory GitHubException.rateLimitExceeded() = GitHubRateLimitExceeded;

  /// Represents a generic or unexpected error not covered by other specific types.
  const factory GitHubException.generic() = GitHubGenericException;

  /// Represents an error that occurred while parsing the API response.
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
