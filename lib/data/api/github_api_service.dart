import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:octo_search/core/enums/repository_filters.dart';
import 'package:octo_search/data/api/index.dart';
import 'package:octo_search/data/models/repository_search.dart';
import 'package:octo_search/data/models/user_profile.dart';
import 'package:octo_search/data/models/user_search.dart';

/// Service class for making requests to the GitHub API.
///
/// This class provides static methods to interact with various GitHub API
/// endpoints, such as searching for users and repositories, and fetching user profiles.
/// It handles API authentication using a personal access token stored securely.
///
/// For more information on the GitHub REST API, see:
/// https://docs.github.com/en/rest
class GitHubApiService {
  /// The default number of items to request per page for paginated API calls.
  static const int defaultPerPage = 30;

  /// The key used to store the GitHub access token in secure storage.
  static const _tokenKey = 'github_access_token';

  /// An instance of [FlutterSecureStorage] for securely storing and retrieving the GitHub access token.
  /// Android options are configured to use encrypted shared preferences.
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  /// Sets (saves) the GitHub personal access token to secure storage.
  ///
  /// [token] The GitHub personal access token string to save.
  static Future<void> setAccessToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Retrieves the GitHub personal access token from secure storage.
  ///
  /// Returns the token string if found, otherwise returns null.
  static Future<String?> _getAccessToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Deletes the GitHub personal access token from secure storage.
  static Future<void> clearAccessToken() async {
    await _storage.delete(key: _tokenKey);
  }

  /// A common private method to fetch data from the GitHub API.
  ///
  /// This method handles the construction of the URI, adding authentication
  /// headers if an access token is available, making the HTTP GET request,
  /// and basic error handling.
  ///
  /// [path] The API endpoint path (e.g., '/search/users').
  /// [queryParams] Optional query parameters for the request.
  /// Returns a [Future] that completes with a [Map<String, dynamic>] representing the JSON response if successful.
  /// Throws a [GitHubException] or [GitHubGenericException] on failure.
  static Future<Map<String, dynamic>> _fetchFromApi(String path, {Map<String, String>? queryParams}) async {
    const String authority = 'api.github.com';

    try {
      final headers = {
        'Accept': 'application/vnd.github.v3+json',
      };

      final token = await _getAccessToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final uri = Uri.https(authority, path, queryParams);
      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        return decodedResponse as Map<String, dynamic>;
      } else {
        throw GitHubException.from(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }
    } catch (e) {
      if (e is GitHubException) {
        rethrow;
      }

      throw GitHubGenericException();
    }
  }

  /// Searches for GitHub users based on the provided query string.
  ///
  /// [query] The search query (e.g., a username or part of a name).
  /// [page] The page number for pagination (defaults to 1).
  /// [perPage] The number of results per page (defaults to [defaultPerPage]).
  /// Returns a [Future] that completes with a [UserSearch] object containing the search results.
  ///
  /// For more information, see: https://docs.github.com/en/rest/search/search#search-users
  static Future<UserSearch> getUsers(
    String query, {
    int page = 1,
    int perPage = defaultPerPage,
  }) async {
    final queryParams = {
      'q': query,
      'page': page.toString(),
      'per_page': perPage.toString(),
    };
    final response = await _fetchFromApi('/search/users', queryParams: queryParams);

    try {
      return UserSearch.fromJson(response);
    } catch (e) {
      throw GitHubParsingException();
    }
  }

  /// Retrieves detailed profile information for a specific GitHub user.
  ///
  /// [username] The GitHub username of the user to fetch.
  /// Returns a [Future] that completes with a [UserProfile] object containing the user's details.
  ///
  /// For more information, see: https://docs.github.com/en/rest/users/users#get-a-user
  static Future<UserProfile> getUserProfile(String username) async {
    final response = await _fetchFromApi('/users/$username');

    try {
      return UserProfile.fromJson(response);
    } catch (e) {
      throw GitHubParsingException();
    }
  }

  /// Searches for repositories owned by a specific user, with optional filters.
  ///
  /// [username] The GitHub username whose repositories are to be searched.
  /// [page] The page number for pagination (defaults to 1).
  /// [perPage] The number of results per page (defaults to [defaultPerPage]).
  /// [filter] A [RepositoryFilters] enum value to filter the results (e.g., non-forked).
  /// Returns a [Future] that completes with a [RepositorySearch] object containing the search results.
  /// Handles a specific [GitHubValidationException] by returning an empty result
  /// as a workaround for an API behavior with users having only private repositories.
  ///
  /// For more information, see: https://docs.github.com/en/rest/search/search#search-repositories
  static Future<RepositorySearch> getRepositories(
    String username, {
    int page = 1,
    int perPage = defaultPerPage,
    RepositoryFilters filter = RepositoryFilters.nonForked,
  }) async {
    final queryParams = {
      'q': 'user:$username ${filter.query}',
      'page': page.toString(),
      'per_page': perPage.toString(),
    };

    try {
      final response = await _fetchFromApi('/search/repositories', queryParams: queryParams);

      return RepositorySearch.fromJson(response);
    } on GitHubValidationException catch (_) {
      // Search Repositories API will return a 422 “Validation Failed” when a user
      // has only private repositories. As a workaround, we return an empty result.
      // See more: https://github.com/orgs/community/discussions/24572
      return RepositorySearch(
        totalCount: 0,
        items: [],
      );
    } catch (e) {
      if (e is GitHubException) {
        rethrow;
      }

      throw GitHubParsingException();
    }
  }
}
