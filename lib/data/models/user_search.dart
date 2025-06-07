import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_search.freezed.dart';
part 'user_search.g.dart';

/// Model representing GitHub user search results.
@freezed
abstract class UserSearch with _$UserSearch {
  const factory UserSearch({
    @JsonKey(name: 'total_count') required int totalCount,
    required List<UserSearchItem> items,
  }) = _UserSearch;

  factory UserSearch.fromJson(Map<String, dynamic> json) =>
      _$UserSearchFromJson(json);
}

/// Model representing an individual user in the GitHub user search results.
@freezed
abstract class UserSearchItem with _$UserSearchItem {
  const factory UserSearchItem({
    required String login,
    required int id,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
    required String type,
  }) = _UserSearchItem;

  factory UserSearchItem.fromJson(Map<String, dynamic> json) =>
      _$UserSearchItemFromJson(json);
}
