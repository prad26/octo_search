import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octo_search/data/models/datetime_converter.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// Model representing a GitHub user profile with detailed information.
/// 
/// This model contains comprehensive information about a GitHub user
/// as returned by the GitHub API's user endpoint.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String login,
    required int id,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
    required String url,
    @JsonKey(name: 'html_url') required String htmlUrl,
    @JsonKey(name: 'organizations_url') required String organizationsUrl,
    @JsonKey(name: 'repos_url') required String reposUrl,
    required String type,
    String? name,
    String? company,
    String? blog,
    String? location,
    String? email,
    String? bio,
    @JsonKey(name: 'public_repos') required int publicRepos,
    @JsonKey(name: 'public_gists') required int publicGists,
    required int followers,
    required int following,
    
    @JsonKey(name: 'created_at') 
    @DateTimeConverter()
    required DateTime createdAt,
    
    @JsonKey(name: 'updated_at') 
    @DateTimeConverter()
    required DateTime updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}
