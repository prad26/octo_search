import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:octo_search/data/models/user_search.dart';
import 'package:octo_search/data/models/user_profile.dart';

// TODO: custom exceptions.

/// Service class for making requests to the GitHub API.
///
/// For more information, see: https://docs.github.com/en/rest
class GitHubApiService {
  static const int defaultPerPage = 30;

  /// A common method to fetch data from the GitHub API.
  ///
  /// [path] - The API endpoint path (excluding the base URL).
  /// [queryParams] - Optional query parameters to include in the request.
  static Future<Map<String, dynamic>> _fetchFromApi(String path, {Map<String, dynamic>? queryParams}) async {
    const String authority = 'api.github.com';

    try {
      final uri = Uri.https(authority, path, queryParams);
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
  /// For more information, see: https://docs.github.com/en/rest/search/search#search-users
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
      throw Exception('Error parsing user profile response: $e');
    }
  }
}
