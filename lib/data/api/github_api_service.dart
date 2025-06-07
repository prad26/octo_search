import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:octo_search/data/models/user_search.dart';

// TODO: custom exceptions.

/// Service class for making requests to the GitHub API.
///
/// For more information, see:
/// https://docs.github.com/en/rest
class GitHubApiService {
  static const String baseUrl = 'https://api.github.com';
  static const int defaultPerPage = 30;

  /// A common method to fetch data from the GitHub API.
  ///
  /// [path] - The API endpoint path (excluding the base URL).
  /// [queryParams] - Optional query parameters to include in the request.
  static Future<Map<String, dynamic>> _fetchFromApi(String path, {Map<String, dynamic>? queryParams}) async {
    const String authority = 'api.github.com';
    final uri = Uri.https(authority, path, queryParams);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/vnd.github.v3+json',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        return decodedResponse as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data from GitHub API, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data from GitHub API: $e');
    }
  }

  /// Searches for GitHub users based on the provided query.
  ///
  /// Returns a [UserSearch] object containing the search results.
  ///
  /// Example:
  /// ```dart
  /// final results = await GitHubApiService.searchUsers('github');
  /// ```
  static Future<UserSearch> searchUsers(
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
      throw Exception('Error parsing user search response: $e');
    }
  }
}
