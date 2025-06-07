// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  login: json['login'] as String,
  id: (json['id'] as num).toInt(),
  avatarUrl: json['avatar_url'] as String,
  url: json['url'] as String,
  htmlUrl: json['html_url'] as String,
  organizationsUrl: json['organizations_url'] as String,
  reposUrl: json['repos_url'] as String,
  type: json['type'] as String,
  name: json['name'] as String?,
  company: json['company'] as String?,
  blog: json['blog'] as String?,
  location: json['location'] as String?,
  email: json['email'] as String?,
  bio: json['bio'] as String?,
  publicRepos: (json['public_repos'] as num).toInt(),
  publicGists: (json['public_gists'] as num).toInt(),
  followers: (json['followers'] as num).toInt(),
  following: (json['following'] as num).toInt(),
  createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
  updatedAt: const DateTimeConverter().fromJson(json['updated_at'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'organizations_url': instance.organizationsUrl,
      'repos_url': instance.reposUrl,
      'type': instance.type,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'bio': instance.bio,
      'public_repos': instance.publicRepos,
      'public_gists': instance.publicGists,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'updated_at': const DateTimeConverter().toJson(instance.updatedAt),
    };
