// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSearch {

@JsonKey(name: 'total_count') int get totalCount; List<UserSearchItem> get items;
/// Create a copy of UserSearch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchCopyWith<UserSearch> get copyWith => _$UserSearchCopyWithImpl<UserSearch>(this as UserSearch, _$identity);

  /// Serializes this UserSearch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearch&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'UserSearch(totalCount: $totalCount, items: $items)';
}


}

/// @nodoc
abstract mixin class $UserSearchCopyWith<$Res>  {
  factory $UserSearchCopyWith(UserSearch value, $Res Function(UserSearch) _then) = _$UserSearchCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_count') int totalCount, List<UserSearchItem> items
});




}
/// @nodoc
class _$UserSearchCopyWithImpl<$Res>
    implements $UserSearchCopyWith<$Res> {
  _$UserSearchCopyWithImpl(this._self, this._then);

  final UserSearch _self;
  final $Res Function(UserSearch) _then;

/// Create a copy of UserSearch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(_self.copyWith(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<UserSearchItem>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UserSearch implements UserSearch {
  const _UserSearch({@JsonKey(name: 'total_count') required this.totalCount, required final  List<UserSearchItem> items}): _items = items;
  factory _UserSearch.fromJson(Map<String, dynamic> json) => _$UserSearchFromJson(json);

@override@JsonKey(name: 'total_count') final  int totalCount;
 final  List<UserSearchItem> _items;
@override List<UserSearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of UserSearch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchCopyWith<_UserSearch> get copyWith => __$UserSearchCopyWithImpl<_UserSearch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSearchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearch&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'UserSearch(totalCount: $totalCount, items: $items)';
}


}

/// @nodoc
abstract mixin class _$UserSearchCopyWith<$Res> implements $UserSearchCopyWith<$Res> {
  factory _$UserSearchCopyWith(_UserSearch value, $Res Function(_UserSearch) _then) = __$UserSearchCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_count') int totalCount, List<UserSearchItem> items
});




}
/// @nodoc
class __$UserSearchCopyWithImpl<$Res>
    implements _$UserSearchCopyWith<$Res> {
  __$UserSearchCopyWithImpl(this._self, this._then);

  final _UserSearch _self;
  final $Res Function(_UserSearch) _then;

/// Create a copy of UserSearch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(_UserSearch(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<UserSearchItem>,
  ));
}


}


/// @nodoc
mixin _$UserSearchItem {

 String get login; int get id;@JsonKey(name: 'avatar_url') String get avatarUrl; String get type;
/// Create a copy of UserSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchItemCopyWith<UserSearchItem> get copyWith => _$UserSearchItemCopyWithImpl<UserSearchItem>(this as UserSearchItem, _$identity);

  /// Serializes this UserSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchItem&&(identical(other.login, login) || other.login == login)&&(identical(other.id, id) || other.id == id)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,login,id,avatarUrl,type);

@override
String toString() {
  return 'UserSearchItem(login: $login, id: $id, avatarUrl: $avatarUrl, type: $type)';
}


}

/// @nodoc
abstract mixin class $UserSearchItemCopyWith<$Res>  {
  factory $UserSearchItemCopyWith(UserSearchItem value, $Res Function(UserSearchItem) _then) = _$UserSearchItemCopyWithImpl;
@useResult
$Res call({
 String login, int id,@JsonKey(name: 'avatar_url') String avatarUrl, String type
});




}
/// @nodoc
class _$UserSearchItemCopyWithImpl<$Res>
    implements $UserSearchItemCopyWith<$Res> {
  _$UserSearchItemCopyWithImpl(this._self, this._then);

  final UserSearchItem _self;
  final $Res Function(UserSearchItem) _then;

/// Create a copy of UserSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? login = null,Object? id = null,Object? avatarUrl = null,Object? type = null,}) {
  return _then(_self.copyWith(
login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UserSearchItem implements UserSearchItem {
  const _UserSearchItem({required this.login, required this.id, @JsonKey(name: 'avatar_url') required this.avatarUrl, required this.type});
  factory _UserSearchItem.fromJson(Map<String, dynamic> json) => _$UserSearchItemFromJson(json);

@override final  String login;
@override final  int id;
@override@JsonKey(name: 'avatar_url') final  String avatarUrl;
@override final  String type;

/// Create a copy of UserSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchItemCopyWith<_UserSearchItem> get copyWith => __$UserSearchItemCopyWithImpl<_UserSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchItem&&(identical(other.login, login) || other.login == login)&&(identical(other.id, id) || other.id == id)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,login,id,avatarUrl,type);

@override
String toString() {
  return 'UserSearchItem(login: $login, id: $id, avatarUrl: $avatarUrl, type: $type)';
}


}

/// @nodoc
abstract mixin class _$UserSearchItemCopyWith<$Res> implements $UserSearchItemCopyWith<$Res> {
  factory _$UserSearchItemCopyWith(_UserSearchItem value, $Res Function(_UserSearchItem) _then) = __$UserSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String login, int id,@JsonKey(name: 'avatar_url') String avatarUrl, String type
});




}
/// @nodoc
class __$UserSearchItemCopyWithImpl<$Res>
    implements _$UserSearchItemCopyWith<$Res> {
  __$UserSearchItemCopyWithImpl(this._self, this._then);

  final _UserSearchItem _self;
  final $Res Function(_UserSearchItem) _then;

/// Create a copy of UserSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? login = null,Object? id = null,Object? avatarUrl = null,Object? type = null,}) {
  return _then(_UserSearchItem(
login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
