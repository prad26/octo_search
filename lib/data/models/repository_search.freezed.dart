// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repository_search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RepositorySearch {

@JsonKey(name: 'total_count') int get totalCount; List<RepositoryItem> get items;
/// Create a copy of RepositorySearch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepositorySearchCopyWith<RepositorySearch> get copyWith => _$RepositorySearchCopyWithImpl<RepositorySearch>(this as RepositorySearch, _$identity);

  /// Serializes this RepositorySearch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepositorySearch&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'RepositorySearch(totalCount: $totalCount, items: $items)';
}


}

/// @nodoc
abstract mixin class $RepositorySearchCopyWith<$Res>  {
  factory $RepositorySearchCopyWith(RepositorySearch value, $Res Function(RepositorySearch) _then) = _$RepositorySearchCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_count') int totalCount, List<RepositoryItem> items
});




}
/// @nodoc
class _$RepositorySearchCopyWithImpl<$Res>
    implements $RepositorySearchCopyWith<$Res> {
  _$RepositorySearchCopyWithImpl(this._self, this._then);

  final RepositorySearch _self;
  final $Res Function(RepositorySearch) _then;

/// Create a copy of RepositorySearch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(_self.copyWith(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<RepositoryItem>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RepositorySearch implements RepositorySearch {
  const _RepositorySearch({@JsonKey(name: 'total_count') required this.totalCount, required final  List<RepositoryItem> items}): _items = items;
  factory _RepositorySearch.fromJson(Map<String, dynamic> json) => _$RepositorySearchFromJson(json);

@override@JsonKey(name: 'total_count') final  int totalCount;
 final  List<RepositoryItem> _items;
@override List<RepositoryItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of RepositorySearch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepositorySearchCopyWith<_RepositorySearch> get copyWith => __$RepositorySearchCopyWithImpl<_RepositorySearch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RepositorySearchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepositorySearch&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'RepositorySearch(totalCount: $totalCount, items: $items)';
}


}

/// @nodoc
abstract mixin class _$RepositorySearchCopyWith<$Res> implements $RepositorySearchCopyWith<$Res> {
  factory _$RepositorySearchCopyWith(_RepositorySearch value, $Res Function(_RepositorySearch) _then) = __$RepositorySearchCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_count') int totalCount, List<RepositoryItem> items
});




}
/// @nodoc
class __$RepositorySearchCopyWithImpl<$Res>
    implements _$RepositorySearchCopyWith<$Res> {
  __$RepositorySearchCopyWithImpl(this._self, this._then);

  final _RepositorySearch _self;
  final $Res Function(_RepositorySearch) _then;

/// Create a copy of RepositorySearch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(_RepositorySearch(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RepositoryItem>,
  ));
}


}


/// @nodoc
mixin _$RepositoryItem {

 int get id; String get name;@JsonKey(name: 'full_name') String get fullName;@JsonKey(name: 'html_url') String get htmlUrl; String? get description; bool get fork;@JsonKey(name: 'stargazers_count') int get stargazersCount;@JsonKey(name: 'watchers_count') int get watchersCount; String? get language;@JsonKey(name: 'forks_count') int get forksCount;@JsonKey(name: 'open_issues_count') int get openIssuesCount; bool get archived; List<String>? get topics;
/// Create a copy of RepositoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepositoryItemCopyWith<RepositoryItem> get copyWith => _$RepositoryItemCopyWithImpl<RepositoryItem>(this as RepositoryItem, _$identity);

  /// Serializes this RepositoryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepositoryItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.fork, fork) || other.fork == fork)&&(identical(other.stargazersCount, stargazersCount) || other.stargazersCount == stargazersCount)&&(identical(other.watchersCount, watchersCount) || other.watchersCount == watchersCount)&&(identical(other.language, language) || other.language == language)&&(identical(other.forksCount, forksCount) || other.forksCount == forksCount)&&(identical(other.openIssuesCount, openIssuesCount) || other.openIssuesCount == openIssuesCount)&&(identical(other.archived, archived) || other.archived == archived)&&const DeepCollectionEquality().equals(other.topics, topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,fullName,htmlUrl,description,fork,stargazersCount,watchersCount,language,forksCount,openIssuesCount,archived,const DeepCollectionEquality().hash(topics));

@override
String toString() {
  return 'RepositoryItem(id: $id, name: $name, fullName: $fullName, htmlUrl: $htmlUrl, description: $description, fork: $fork, stargazersCount: $stargazersCount, watchersCount: $watchersCount, language: $language, forksCount: $forksCount, openIssuesCount: $openIssuesCount, archived: $archived, topics: $topics)';
}


}

/// @nodoc
abstract mixin class $RepositoryItemCopyWith<$Res>  {
  factory $RepositoryItemCopyWith(RepositoryItem value, $Res Function(RepositoryItem) _then) = _$RepositoryItemCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'html_url') String htmlUrl, String? description, bool fork,@JsonKey(name: 'stargazers_count') int stargazersCount,@JsonKey(name: 'watchers_count') int watchersCount, String? language,@JsonKey(name: 'forks_count') int forksCount,@JsonKey(name: 'open_issues_count') int openIssuesCount, bool archived, List<String>? topics
});




}
/// @nodoc
class _$RepositoryItemCopyWithImpl<$Res>
    implements $RepositoryItemCopyWith<$Res> {
  _$RepositoryItemCopyWithImpl(this._self, this._then);

  final RepositoryItem _self;
  final $Res Function(RepositoryItem) _then;

/// Create a copy of RepositoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? fullName = null,Object? htmlUrl = null,Object? description = freezed,Object? fork = null,Object? stargazersCount = null,Object? watchersCount = null,Object? language = freezed,Object? forksCount = null,Object? openIssuesCount = null,Object? archived = null,Object? topics = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,htmlUrl: null == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,fork: null == fork ? _self.fork : fork // ignore: cast_nullable_to_non_nullable
as bool,stargazersCount: null == stargazersCount ? _self.stargazersCount : stargazersCount // ignore: cast_nullable_to_non_nullable
as int,watchersCount: null == watchersCount ? _self.watchersCount : watchersCount // ignore: cast_nullable_to_non_nullable
as int,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,forksCount: null == forksCount ? _self.forksCount : forksCount // ignore: cast_nullable_to_non_nullable
as int,openIssuesCount: null == openIssuesCount ? _self.openIssuesCount : openIssuesCount // ignore: cast_nullable_to_non_nullable
as int,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,topics: freezed == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RepositoryItem implements RepositoryItem {
  const _RepositoryItem({required this.id, required this.name, @JsonKey(name: 'full_name') required this.fullName, @JsonKey(name: 'html_url') required this.htmlUrl, this.description, required this.fork, @JsonKey(name: 'stargazers_count') required this.stargazersCount, @JsonKey(name: 'watchers_count') required this.watchersCount, this.language, @JsonKey(name: 'forks_count') required this.forksCount, @JsonKey(name: 'open_issues_count') required this.openIssuesCount, required this.archived, final  List<String>? topics}): _topics = topics;
  factory _RepositoryItem.fromJson(Map<String, dynamic> json) => _$RepositoryItemFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'full_name') final  String fullName;
@override@JsonKey(name: 'html_url') final  String htmlUrl;
@override final  String? description;
@override final  bool fork;
@override@JsonKey(name: 'stargazers_count') final  int stargazersCount;
@override@JsonKey(name: 'watchers_count') final  int watchersCount;
@override final  String? language;
@override@JsonKey(name: 'forks_count') final  int forksCount;
@override@JsonKey(name: 'open_issues_count') final  int openIssuesCount;
@override final  bool archived;
 final  List<String>? _topics;
@override List<String>? get topics {
  final value = _topics;
  if (value == null) return null;
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of RepositoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepositoryItemCopyWith<_RepositoryItem> get copyWith => __$RepositoryItemCopyWithImpl<_RepositoryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RepositoryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepositoryItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.fork, fork) || other.fork == fork)&&(identical(other.stargazersCount, stargazersCount) || other.stargazersCount == stargazersCount)&&(identical(other.watchersCount, watchersCount) || other.watchersCount == watchersCount)&&(identical(other.language, language) || other.language == language)&&(identical(other.forksCount, forksCount) || other.forksCount == forksCount)&&(identical(other.openIssuesCount, openIssuesCount) || other.openIssuesCount == openIssuesCount)&&(identical(other.archived, archived) || other.archived == archived)&&const DeepCollectionEquality().equals(other._topics, _topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,fullName,htmlUrl,description,fork,stargazersCount,watchersCount,language,forksCount,openIssuesCount,archived,const DeepCollectionEquality().hash(_topics));

@override
String toString() {
  return 'RepositoryItem(id: $id, name: $name, fullName: $fullName, htmlUrl: $htmlUrl, description: $description, fork: $fork, stargazersCount: $stargazersCount, watchersCount: $watchersCount, language: $language, forksCount: $forksCount, openIssuesCount: $openIssuesCount, archived: $archived, topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$RepositoryItemCopyWith<$Res> implements $RepositoryItemCopyWith<$Res> {
  factory _$RepositoryItemCopyWith(_RepositoryItem value, $Res Function(_RepositoryItem) _then) = __$RepositoryItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'html_url') String htmlUrl, String? description, bool fork,@JsonKey(name: 'stargazers_count') int stargazersCount,@JsonKey(name: 'watchers_count') int watchersCount, String? language,@JsonKey(name: 'forks_count') int forksCount,@JsonKey(name: 'open_issues_count') int openIssuesCount, bool archived, List<String>? topics
});




}
/// @nodoc
class __$RepositoryItemCopyWithImpl<$Res>
    implements _$RepositoryItemCopyWith<$Res> {
  __$RepositoryItemCopyWithImpl(this._self, this._then);

  final _RepositoryItem _self;
  final $Res Function(_RepositoryItem) _then;

/// Create a copy of RepositoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? fullName = null,Object? htmlUrl = null,Object? description = freezed,Object? fork = null,Object? stargazersCount = null,Object? watchersCount = null,Object? language = freezed,Object? forksCount = null,Object? openIssuesCount = null,Object? archived = null,Object? topics = freezed,}) {
  return _then(_RepositoryItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,htmlUrl: null == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,fork: null == fork ? _self.fork : fork // ignore: cast_nullable_to_non_nullable
as bool,stargazersCount: null == stargazersCount ? _self.stargazersCount : stargazersCount // ignore: cast_nullable_to_non_nullable
as int,watchersCount: null == watchersCount ? _self.watchersCount : watchersCount // ignore: cast_nullable_to_non_nullable
as int,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,forksCount: null == forksCount ? _self.forksCount : forksCount // ignore: cast_nullable_to_non_nullable
as int,openIssuesCount: null == openIssuesCount ? _self.openIssuesCount : openIssuesCount // ignore: cast_nullable_to_non_nullable
as int,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,topics: freezed == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
