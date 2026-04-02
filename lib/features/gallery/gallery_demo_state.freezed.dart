// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_demo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GalleryDemoState {

 bool get notificationsEnabled; bool get termsAccepted; int get planIndex; double get sliderFraction; int get paginationPageIndex;
/// Create a copy of GalleryDemoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GalleryDemoStateCopyWith<GalleryDemoState> get copyWith => _$GalleryDemoStateCopyWithImpl<GalleryDemoState>(this as GalleryDemoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GalleryDemoState&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.termsAccepted, termsAccepted) || other.termsAccepted == termsAccepted)&&(identical(other.planIndex, planIndex) || other.planIndex == planIndex)&&(identical(other.sliderFraction, sliderFraction) || other.sliderFraction == sliderFraction)&&(identical(other.paginationPageIndex, paginationPageIndex) || other.paginationPageIndex == paginationPageIndex));
}


@override
int get hashCode => Object.hash(runtimeType,notificationsEnabled,termsAccepted,planIndex,sliderFraction,paginationPageIndex);

@override
String toString() {
  return 'GalleryDemoState(notificationsEnabled: $notificationsEnabled, termsAccepted: $termsAccepted, planIndex: $planIndex, sliderFraction: $sliderFraction, paginationPageIndex: $paginationPageIndex)';
}


}

/// @nodoc
abstract mixin class $GalleryDemoStateCopyWith<$Res>  {
  factory $GalleryDemoStateCopyWith(GalleryDemoState value, $Res Function(GalleryDemoState) _then) = _$GalleryDemoStateCopyWithImpl;
@useResult
$Res call({
 bool notificationsEnabled, bool termsAccepted, int planIndex, double sliderFraction, int paginationPageIndex
});




}
/// @nodoc
class _$GalleryDemoStateCopyWithImpl<$Res>
    implements $GalleryDemoStateCopyWith<$Res> {
  _$GalleryDemoStateCopyWithImpl(this._self, this._then);

  final GalleryDemoState _self;
  final $Res Function(GalleryDemoState) _then;

/// Create a copy of GalleryDemoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationsEnabled = null,Object? termsAccepted = null,Object? planIndex = null,Object? sliderFraction = null,Object? paginationPageIndex = null,}) {
  return _then(_self.copyWith(
notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,termsAccepted: null == termsAccepted ? _self.termsAccepted : termsAccepted // ignore: cast_nullable_to_non_nullable
as bool,planIndex: null == planIndex ? _self.planIndex : planIndex // ignore: cast_nullable_to_non_nullable
as int,sliderFraction: null == sliderFraction ? _self.sliderFraction : sliderFraction // ignore: cast_nullable_to_non_nullable
as double,paginationPageIndex: null == paginationPageIndex ? _self.paginationPageIndex : paginationPageIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GalleryDemoState].
extension GalleryDemoStatePatterns on GalleryDemoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GalleryDemoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GalleryDemoState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GalleryDemoState value)  $default,){
final _that = this;
switch (_that) {
case _GalleryDemoState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GalleryDemoState value)?  $default,){
final _that = this;
switch (_that) {
case _GalleryDemoState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool notificationsEnabled,  bool termsAccepted,  int planIndex,  double sliderFraction,  int paginationPageIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GalleryDemoState() when $default != null:
return $default(_that.notificationsEnabled,_that.termsAccepted,_that.planIndex,_that.sliderFraction,_that.paginationPageIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool notificationsEnabled,  bool termsAccepted,  int planIndex,  double sliderFraction,  int paginationPageIndex)  $default,) {final _that = this;
switch (_that) {
case _GalleryDemoState():
return $default(_that.notificationsEnabled,_that.termsAccepted,_that.planIndex,_that.sliderFraction,_that.paginationPageIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool notificationsEnabled,  bool termsAccepted,  int planIndex,  double sliderFraction,  int paginationPageIndex)?  $default,) {final _that = this;
switch (_that) {
case _GalleryDemoState() when $default != null:
return $default(_that.notificationsEnabled,_that.termsAccepted,_that.planIndex,_that.sliderFraction,_that.paginationPageIndex);case _:
  return null;

}
}

}

/// @nodoc


class _GalleryDemoState implements GalleryDemoState {
  const _GalleryDemoState({this.notificationsEnabled = true, this.termsAccepted = false, this.planIndex = 0, this.sliderFraction = 0.35, this.paginationPageIndex = 0});
  

@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  bool termsAccepted;
@override@JsonKey() final  int planIndex;
@override@JsonKey() final  double sliderFraction;
@override@JsonKey() final  int paginationPageIndex;

/// Create a copy of GalleryDemoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryDemoStateCopyWith<_GalleryDemoState> get copyWith => __$GalleryDemoStateCopyWithImpl<_GalleryDemoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryDemoState&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.termsAccepted, termsAccepted) || other.termsAccepted == termsAccepted)&&(identical(other.planIndex, planIndex) || other.planIndex == planIndex)&&(identical(other.sliderFraction, sliderFraction) || other.sliderFraction == sliderFraction)&&(identical(other.paginationPageIndex, paginationPageIndex) || other.paginationPageIndex == paginationPageIndex));
}


@override
int get hashCode => Object.hash(runtimeType,notificationsEnabled,termsAccepted,planIndex,sliderFraction,paginationPageIndex);

@override
String toString() {
  return 'GalleryDemoState(notificationsEnabled: $notificationsEnabled, termsAccepted: $termsAccepted, planIndex: $planIndex, sliderFraction: $sliderFraction, paginationPageIndex: $paginationPageIndex)';
}


}

/// @nodoc
abstract mixin class _$GalleryDemoStateCopyWith<$Res> implements $GalleryDemoStateCopyWith<$Res> {
  factory _$GalleryDemoStateCopyWith(_GalleryDemoState value, $Res Function(_GalleryDemoState) _then) = __$GalleryDemoStateCopyWithImpl;
@override @useResult
$Res call({
 bool notificationsEnabled, bool termsAccepted, int planIndex, double sliderFraction, int paginationPageIndex
});




}
/// @nodoc
class __$GalleryDemoStateCopyWithImpl<$Res>
    implements _$GalleryDemoStateCopyWith<$Res> {
  __$GalleryDemoStateCopyWithImpl(this._self, this._then);

  final _GalleryDemoState _self;
  final $Res Function(_GalleryDemoState) _then;

/// Create a copy of GalleryDemoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationsEnabled = null,Object? termsAccepted = null,Object? planIndex = null,Object? sliderFraction = null,Object? paginationPageIndex = null,}) {
  return _then(_GalleryDemoState(
notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,termsAccepted: null == termsAccepted ? _self.termsAccepted : termsAccepted // ignore: cast_nullable_to_non_nullable
as bool,planIndex: null == planIndex ? _self.planIndex : planIndex // ignore: cast_nullable_to_non_nullable
as int,sliderFraction: null == sliderFraction ? _self.sliderFraction : sliderFraction // ignore: cast_nullable_to_non_nullable
as double,paginationPageIndex: null == paginationPageIndex ? _self.paginationPageIndex : paginationPageIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
