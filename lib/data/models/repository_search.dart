import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository_search.freezed.dart';
part 'repository_search.g.dart';

/// Model representing GitHub repository search results.
///
/// This model contains the search results returned by the GitHub API's repository search endpoint.
/// It includes the total count of matching repositories and a list of repository items with detailed information.
@freezed
abstract class RepositorySearch with _$RepositorySearch {
  const factory RepositorySearch({
    @JsonKey(name: 'total_count') required int totalCount,
    required List<RepositoryItem> items,
  }) = _RepositorySearch;

  factory RepositorySearch.fromJson(Map<String, dynamic> json) => _$RepositorySearchFromJson(json);
}

/// Model representing an individual repository in the GitHub repository search results.
///
/// This model contains detailed information about a GitHub repository as returned in search results,
/// including statistics like stars and forks.
@freezed
abstract class RepositoryItem with _$RepositoryItem {
  const factory RepositoryItem({
    required int id,
    required String name,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'html_url') required String htmlUrl,
    String? description,
    required bool fork,
    @JsonKey(name: 'stargazers_count') required int stargazersCount,
    @JsonKey(name: 'watchers_count') required int watchersCount,
    String? language,
    @JsonKey(name: 'forks_count') required int forksCount,
    @JsonKey(name: 'open_issues_count') required int openIssuesCount,
    required bool archived,
    List<String>? topics,
  }) = _RepositoryItem;

  factory RepositoryItem.fromJson(Map<String, dynamic> json) => _$RepositoryItemFromJson(json);
}
