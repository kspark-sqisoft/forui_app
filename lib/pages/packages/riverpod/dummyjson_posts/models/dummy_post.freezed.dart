// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dummy_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostReactions {

 int get likes; int get dislikes;
/// Create a copy of PostReactions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostReactionsCopyWith<PostReactions> get copyWith => _$PostReactionsCopyWithImpl<PostReactions>(this as PostReactions, _$identity);

  /// Serializes this PostReactions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostReactions&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.dislikes, dislikes) || other.dislikes == dislikes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,likes,dislikes);

@override
String toString() {
  return 'PostReactions(likes: $likes, dislikes: $dislikes)';
}


}

/// @nodoc
abstract mixin class $PostReactionsCopyWith<$Res>  {
  factory $PostReactionsCopyWith(PostReactions value, $Res Function(PostReactions) _then) = _$PostReactionsCopyWithImpl;
@useResult
$Res call({
 int likes, int dislikes
});




}
/// @nodoc
class _$PostReactionsCopyWithImpl<$Res>
    implements $PostReactionsCopyWith<$Res> {
  _$PostReactionsCopyWithImpl(this._self, this._then);

  final PostReactions _self;
  final $Res Function(PostReactions) _then;

/// Create a copy of PostReactions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? likes = null,Object? dislikes = null,}) {
  return _then(_self.copyWith(
likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,dislikes: null == dislikes ? _self.dislikes : dislikes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PostReactions].
extension PostReactionsPatterns on PostReactions {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostReactions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostReactions() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostReactions value)  $default,){
final _that = this;
switch (_that) {
case _PostReactions():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostReactions value)?  $default,){
final _that = this;
switch (_that) {
case _PostReactions() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int likes,  int dislikes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostReactions() when $default != null:
return $default(_that.likes,_that.dislikes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int likes,  int dislikes)  $default,) {final _that = this;
switch (_that) {
case _PostReactions():
return $default(_that.likes,_that.dislikes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int likes,  int dislikes)?  $default,) {final _that = this;
switch (_that) {
case _PostReactions() when $default != null:
return $default(_that.likes,_that.dislikes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostReactions implements PostReactions {
  const _PostReactions({required this.likes, required this.dislikes});
  factory _PostReactions.fromJson(Map<String, dynamic> json) => _$PostReactionsFromJson(json);

@override final  int likes;
@override final  int dislikes;

/// Create a copy of PostReactions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostReactionsCopyWith<_PostReactions> get copyWith => __$PostReactionsCopyWithImpl<_PostReactions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostReactionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostReactions&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.dislikes, dislikes) || other.dislikes == dislikes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,likes,dislikes);

@override
String toString() {
  return 'PostReactions(likes: $likes, dislikes: $dislikes)';
}


}

/// @nodoc
abstract mixin class _$PostReactionsCopyWith<$Res> implements $PostReactionsCopyWith<$Res> {
  factory _$PostReactionsCopyWith(_PostReactions value, $Res Function(_PostReactions) _then) = __$PostReactionsCopyWithImpl;
@override @useResult
$Res call({
 int likes, int dislikes
});




}
/// @nodoc
class __$PostReactionsCopyWithImpl<$Res>
    implements _$PostReactionsCopyWith<$Res> {
  __$PostReactionsCopyWithImpl(this._self, this._then);

  final _PostReactions _self;
  final $Res Function(_PostReactions) _then;

/// Create a copy of PostReactions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? likes = null,Object? dislikes = null,}) {
  return _then(_PostReactions(
likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,dislikes: null == dislikes ? _self.dislikes : dislikes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DummyPost {

 int get id; String get title; String get body; List<String> get tags; PostReactions? get reactions; int? get views; int get userId;
/// Create a copy of DummyPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DummyPostCopyWith<DummyPost> get copyWith => _$DummyPostCopyWithImpl<DummyPost>(this as DummyPost, _$identity);

  /// Serializes this DummyPost to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DummyPost&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.reactions, reactions) || other.reactions == reactions)&&(identical(other.views, views) || other.views == views)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,const DeepCollectionEquality().hash(tags),reactions,views,userId);

@override
String toString() {
  return 'DummyPost(id: $id, title: $title, body: $body, tags: $tags, reactions: $reactions, views: $views, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $DummyPostCopyWith<$Res>  {
  factory $DummyPostCopyWith(DummyPost value, $Res Function(DummyPost) _then) = _$DummyPostCopyWithImpl;
@useResult
$Res call({
 int id, String title, String body, List<String> tags, PostReactions? reactions, int? views, int userId
});


$PostReactionsCopyWith<$Res>? get reactions;

}
/// @nodoc
class _$DummyPostCopyWithImpl<$Res>
    implements $DummyPostCopyWith<$Res> {
  _$DummyPostCopyWithImpl(this._self, this._then);

  final DummyPost _self;
  final $Res Function(DummyPost) _then;

/// Create a copy of DummyPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? tags = null,Object? reactions = freezed,Object? views = freezed,Object? userId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,reactions: freezed == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as PostReactions?,views: freezed == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DummyPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostReactionsCopyWith<$Res>? get reactions {
    if (_self.reactions == null) {
    return null;
  }

  return $PostReactionsCopyWith<$Res>(_self.reactions!, (value) {
    return _then(_self.copyWith(reactions: value));
  });
}
}


/// Adds pattern-matching-related methods to [DummyPost].
extension DummyPostPatterns on DummyPost {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DummyPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DummyPost() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DummyPost value)  $default,){
final _that = this;
switch (_that) {
case _DummyPost():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DummyPost value)?  $default,){
final _that = this;
switch (_that) {
case _DummyPost() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String body,  List<String> tags,  PostReactions? reactions,  int? views,  int userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DummyPost() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.tags,_that.reactions,_that.views,_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String body,  List<String> tags,  PostReactions? reactions,  int? views,  int userId)  $default,) {final _that = this;
switch (_that) {
case _DummyPost():
return $default(_that.id,_that.title,_that.body,_that.tags,_that.reactions,_that.views,_that.userId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String body,  List<String> tags,  PostReactions? reactions,  int? views,  int userId)?  $default,) {final _that = this;
switch (_that) {
case _DummyPost() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.tags,_that.reactions,_that.views,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DummyPost implements DummyPost {
  const _DummyPost({required this.id, required this.title, this.body = '', final  List<String> tags = const <String>[], this.reactions, this.views, this.userId = 1}): _tags = tags;
  factory _DummyPost.fromJson(Map<String, dynamic> json) => _$DummyPostFromJson(json);

@override final  int id;
@override final  String title;
@override@JsonKey() final  String body;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  PostReactions? reactions;
@override final  int? views;
@override@JsonKey() final  int userId;

/// Create a copy of DummyPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DummyPostCopyWith<_DummyPost> get copyWith => __$DummyPostCopyWithImpl<_DummyPost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DummyPostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DummyPost&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.reactions, reactions) || other.reactions == reactions)&&(identical(other.views, views) || other.views == views)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,const DeepCollectionEquality().hash(_tags),reactions,views,userId);

@override
String toString() {
  return 'DummyPost(id: $id, title: $title, body: $body, tags: $tags, reactions: $reactions, views: $views, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$DummyPostCopyWith<$Res> implements $DummyPostCopyWith<$Res> {
  factory _$DummyPostCopyWith(_DummyPost value, $Res Function(_DummyPost) _then) = __$DummyPostCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String body, List<String> tags, PostReactions? reactions, int? views, int userId
});


@override $PostReactionsCopyWith<$Res>? get reactions;

}
/// @nodoc
class __$DummyPostCopyWithImpl<$Res>
    implements _$DummyPostCopyWith<$Res> {
  __$DummyPostCopyWithImpl(this._self, this._then);

  final _DummyPost _self;
  final $Res Function(_DummyPost) _then;

/// Create a copy of DummyPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? tags = null,Object? reactions = freezed,Object? views = freezed,Object? userId = null,}) {
  return _then(_DummyPost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,reactions: freezed == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as PostReactions?,views: freezed == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DummyPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostReactionsCopyWith<$Res>? get reactions {
    if (_self.reactions == null) {
    return null;
  }

  return $PostReactionsCopyWith<$Res>(_self.reactions!, (value) {
    return _then(_self.copyWith(reactions: value));
  });
}
}


/// @nodoc
mixin _$PostsListPage {

 List<DummyPost> get posts; int get total; int get skip; int get limit;
/// Create a copy of PostsListPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostsListPageCopyWith<PostsListPage> get copyWith => _$PostsListPageCopyWithImpl<PostsListPage>(this as PostsListPage, _$identity);

  /// Serializes this PostsListPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostsListPage&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(posts),total,skip,limit);

@override
String toString() {
  return 'PostsListPage(posts: $posts, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $PostsListPageCopyWith<$Res>  {
  factory $PostsListPageCopyWith(PostsListPage value, $Res Function(PostsListPage) _then) = _$PostsListPageCopyWithImpl;
@useResult
$Res call({
 List<DummyPost> posts, int total, int skip, int limit
});




}
/// @nodoc
class _$PostsListPageCopyWithImpl<$Res>
    implements $PostsListPageCopyWith<$Res> {
  _$PostsListPageCopyWithImpl(this._self, this._then);

  final PostsListPage _self;
  final $Res Function(PostsListPage) _then;

/// Create a copy of PostsListPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? posts = null,Object? total = null,Object? skip = null,Object? limit = null,}) {
  return _then(_self.copyWith(
posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<DummyPost>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PostsListPage].
extension PostsListPagePatterns on PostsListPage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostsListPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostsListPage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostsListPage value)  $default,){
final _that = this;
switch (_that) {
case _PostsListPage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostsListPage value)?  $default,){
final _that = this;
switch (_that) {
case _PostsListPage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DummyPost> posts,  int total,  int skip,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostsListPage() when $default != null:
return $default(_that.posts,_that.total,_that.skip,_that.limit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DummyPost> posts,  int total,  int skip,  int limit)  $default,) {final _that = this;
switch (_that) {
case _PostsListPage():
return $default(_that.posts,_that.total,_that.skip,_that.limit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DummyPost> posts,  int total,  int skip,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _PostsListPage() when $default != null:
return $default(_that.posts,_that.total,_that.skip,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostsListPage implements PostsListPage {
  const _PostsListPage({required final  List<DummyPost> posts, required this.total, required this.skip, required this.limit}): _posts = posts;
  factory _PostsListPage.fromJson(Map<String, dynamic> json) => _$PostsListPageFromJson(json);

 final  List<DummyPost> _posts;
@override List<DummyPost> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override final  int total;
@override final  int skip;
@override final  int limit;

/// Create a copy of PostsListPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostsListPageCopyWith<_PostsListPage> get copyWith => __$PostsListPageCopyWithImpl<_PostsListPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostsListPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostsListPage&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts),total,skip,limit);

@override
String toString() {
  return 'PostsListPage(posts: $posts, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$PostsListPageCopyWith<$Res> implements $PostsListPageCopyWith<$Res> {
  factory _$PostsListPageCopyWith(_PostsListPage value, $Res Function(_PostsListPage) _then) = __$PostsListPageCopyWithImpl;
@override @useResult
$Res call({
 List<DummyPost> posts, int total, int skip, int limit
});




}
/// @nodoc
class __$PostsListPageCopyWithImpl<$Res>
    implements _$PostsListPageCopyWith<$Res> {
  __$PostsListPageCopyWithImpl(this._self, this._then);

  final _PostsListPage _self;
  final $Res Function(_PostsListPage) _then;

/// Create a copy of PostsListPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? posts = null,Object? total = null,Object? skip = null,Object? limit = null,}) {
  return _then(_PostsListPage(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<DummyPost>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
