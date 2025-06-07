import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:octo_search/core/enums/repository_filters.dart';
import 'package:octo_search/data/api/github_api_exception.dart';
import 'package:octo_search/data/models/repository_search.dart';
import 'package:octo_search/data/models/user_search.dart';
import 'package:octo_search/data/models/user_profile.dart';

/// Service class for making requests to the GitHub API.
///
/// For more information, see: https://docs.github.com/en/rest
class GitHubApiService {
  static const int defaultPerPage = 30;

  static const _tokenKey = 'github_access_token';
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static Future<void> setAccessToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> _getAccessToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// A common method to fetch data from the GitHub API.
  ///
  /// [path] - The API endpoint path (excluding the base URL).
  /// [queryParams] - Optional query parameters to include in the request.
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

  /// Searches for GitHub users based on the provided query.
  ///
  /// Returns a [UserSearch] object containing the search results.
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
  /// Returns a [UserProfile] object containing the user's details.
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

  /// Searches for repositories owned by a specific user with optional filters.
  ///
  /// Returns a [RepositorySearch] object containing the search results.
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
