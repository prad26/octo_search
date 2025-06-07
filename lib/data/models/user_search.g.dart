// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSearch _$UserSearchFromJson(Map<String, dynamic> json) => _UserSearch(
  totalCount: (json['total_count'] as num).toInt(),
  items: (json['items'] as List<dynamic>)
      .map((e) => UserSearchItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserSearchToJson(_UserSearch instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'items': instance.items,
    };

_UserSearchItem _$UserSearchItemFromJson(Map<String, dynamic> json) =>
    _UserSearchItem(
      login: json['login'] as String,
      id: (json['id'] as num).toInt(),
      avatarUrl: json['avatar_url'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$UserSearchItemToJson(_UserSearchItem instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
      'type': instance.type,
    };
