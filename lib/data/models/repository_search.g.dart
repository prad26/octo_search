// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RepositorySearch _$RepositorySearchFromJson(Map<String, dynamic> json) =>
    _RepositorySearch(
      totalCount: (json['total_count'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => RepositoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RepositorySearchToJson(_RepositorySearch instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'items': instance.items,
    };

_RepositoryItem _$RepositoryItemFromJson(Map<String, dynamic> json) =>
    _RepositoryItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      htmlUrl: json['html_url'] as String,
      description: json['description'] as String?,
      fork: json['fork'] as bool,
      stargazersCount: (json['stargazers_count'] as num).toInt(),
      watchersCount: (json['watchers_count'] as num).toInt(),
      language: json['language'] as String?,
      forksCount: (json['forks_count'] as num).toInt(),
      openIssuesCount: (json['open_issues_count'] as num).toInt(),
      archived: json['archived'] as bool,
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RepositoryItemToJson(_RepositoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'html_url': instance.htmlUrl,
      'description': instance.description,
      'fork': instance.fork,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'open_issues_count': instance.openIssuesCount,
      'archived': instance.archived,
      'topics': instance.topics,
    };
