// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BaseState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseState<$T>()';
}


}

/// @nodoc
class $BaseStateCopyWith<T,$Res>  {
$BaseStateCopyWith(BaseState<T> _, $Res Function(BaseState<T>) __);
}


/// Adds pattern-matching-related methods to [BaseState].
extension BaseStatePatterns<T> on BaseState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BaseStateInitial<T> value)?  initial,TResult Function( BaseStateLoading<T> value)?  loading,TResult Function( BaseStateSuccess<T> value)?  success,TResult Function( BaseStateError<T> value)?  error,TResult Function( BaseStateEmpty<T> value)?  empty,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BaseStateInitial() when initial != null:
return initial(_that);case BaseStateLoading() when loading != null:
return loading(_that);case BaseStateSuccess() when success != null:
return success(_that);case BaseStateError() when error != null:
return error(_that);case BaseStateEmpty() when empty != null:
return empty(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BaseStateInitial<T> value)  initial,required TResult Function( BaseStateLoading<T> value)  loading,required TResult Function( BaseStateSuccess<T> value)  success,required TResult Function( BaseStateError<T> value)  error,required TResult Function( BaseStateEmpty<T> value)  empty,}){
final _that = this;
switch (_that) {
case BaseStateInitial():
return initial(_that);case BaseStateLoading():
return loading(_that);case BaseStateSuccess():
return success(_that);case BaseStateError():
return error(_that);case BaseStateEmpty():
return empty(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BaseStateInitial<T> value)?  initial,TResult? Function( BaseStateLoading<T> value)?  loading,TResult? Function( BaseStateSuccess<T> value)?  success,TResult? Function( BaseStateError<T> value)?  error,TResult? Function( BaseStateEmpty<T> value)?  empty,}){
final _that = this;
switch (_that) {
case BaseStateInitial() when initial != null:
return initial(_that);case BaseStateLoading() when loading != null:
return loading(_that);case BaseStateSuccess() when success != null:
return success(_that);case BaseStateError() when error != null:
return error(_that);case BaseStateEmpty() when empty != null:
return empty(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String? message)?  loading,TResult Function( T data,  String? message)?  success,TResult Function( String message,  Object? error,  StackTrace? stackTrace)?  error,TResult Function( String? message)?  empty,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BaseStateInitial() when initial != null:
return initial();case BaseStateLoading() when loading != null:
return loading(_that.message);case BaseStateSuccess() when success != null:
return success(_that.data,_that.message);case BaseStateError() when error != null:
return error(_that.message,_that.error,_that.stackTrace);case BaseStateEmpty() when empty != null:
return empty(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String? message)  loading,required TResult Function( T data,  String? message)  success,required TResult Function( String message,  Object? error,  StackTrace? stackTrace)  error,required TResult Function( String? message)  empty,}) {final _that = this;
switch (_that) {
case BaseStateInitial():
return initial();case BaseStateLoading():
return loading(_that.message);case BaseStateSuccess():
return success(_that.data,_that.message);case BaseStateError():
return error(_that.message,_that.error,_that.stackTrace);case BaseStateEmpty():
return empty(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String? message)?  loading,TResult? Function( T data,  String? message)?  success,TResult? Function( String message,  Object? error,  StackTrace? stackTrace)?  error,TResult? Function( String? message)?  empty,}) {final _that = this;
switch (_that) {
case BaseStateInitial() when initial != null:
return initial();case BaseStateLoading() when loading != null:
return loading(_that.message);case BaseStateSuccess() when success != null:
return success(_that.data,_that.message);case BaseStateError() when error != null:
return error(_that.message,_that.error,_that.stackTrace);case BaseStateEmpty() when empty != null:
return empty(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BaseStateInitial<T> implements BaseState<T> {
  const BaseStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseStateInitial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseState<$T>.initial()';
}


}




/// @nodoc


class BaseStateLoading<T> implements BaseState<T> {
  const BaseStateLoading([this.message]);
  

 final  String? message;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseStateLoadingCopyWith<T, BaseStateLoading<T>> get copyWith => _$BaseStateLoadingCopyWithImpl<T, BaseStateLoading<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseStateLoading<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BaseState<$T>.loading(message: $message)';
}


}

/// @nodoc
abstract mixin class $BaseStateLoadingCopyWith<T,$Res> implements $BaseStateCopyWith<T, $Res> {
  factory $BaseStateLoadingCopyWith(BaseStateLoading<T> value, $Res Function(BaseStateLoading<T>) _then) = _$BaseStateLoadingCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$BaseStateLoadingCopyWithImpl<T,$Res>
    implements $BaseStateLoadingCopyWith<T, $Res> {
  _$BaseStateLoadingCopyWithImpl(this._self, this._then);

  final BaseStateLoading<T> _self;
  final $Res Function(BaseStateLoading<T>) _then;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(BaseStateLoading<T>(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BaseStateSuccess<T> implements BaseState<T> {
  const BaseStateSuccess({required this.data, this.message});
  

 final  T data;
 final  String? message;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseStateSuccessCopyWith<T, BaseStateSuccess<T>> get copyWith => _$BaseStateSuccessCopyWithImpl<T, BaseStateSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseStateSuccess<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),message);

@override
String toString() {
  return 'BaseState<$T>.success(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class $BaseStateSuccessCopyWith<T,$Res> implements $BaseStateCopyWith<T, $Res> {
  factory $BaseStateSuccessCopyWith(BaseStateSuccess<T> value, $Res Function(BaseStateSuccess<T>) _then) = _$BaseStateSuccessCopyWithImpl;
@useResult
$Res call({
 T data, String? message
});




}
/// @nodoc
class _$BaseStateSuccessCopyWithImpl<T,$Res>
    implements $BaseStateSuccessCopyWith<T, $Res> {
  _$BaseStateSuccessCopyWithImpl(this._self, this._then);

  final BaseStateSuccess<T> _self;
  final $Res Function(BaseStateSuccess<T>) _then;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? message = freezed,}) {
  return _then(BaseStateSuccess<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BaseStateError<T> implements BaseState<T> {
  const BaseStateError({required this.message, this.error, this.stackTrace});
  

 final  String message;
 final  Object? error;
 final  StackTrace? stackTrace;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseStateErrorCopyWith<T, BaseStateError<T>> get copyWith => _$BaseStateErrorCopyWithImpl<T, BaseStateError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseStateError<T>&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'BaseState<$T>.error(message: $message, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $BaseStateErrorCopyWith<T,$Res> implements $BaseStateCopyWith<T, $Res> {
  factory $BaseStateErrorCopyWith(BaseStateError<T> value, $Res Function(BaseStateError<T>) _then) = _$BaseStateErrorCopyWithImpl;
@useResult
$Res call({
 String message, Object? error, StackTrace? stackTrace
});




}
/// @nodoc
class _$BaseStateErrorCopyWithImpl<T,$Res>
    implements $BaseStateErrorCopyWith<T, $Res> {
  _$BaseStateErrorCopyWithImpl(this._self, this._then);

  final BaseStateError<T> _self;
  final $Res Function(BaseStateError<T>) _then;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? error = freezed,Object? stackTrace = freezed,}) {
  return _then(BaseStateError<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error ,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class BaseStateEmpty<T> implements BaseState<T> {
  const BaseStateEmpty([this.message]);
  

 final  String? message;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseStateEmptyCopyWith<T, BaseStateEmpty<T>> get copyWith => _$BaseStateEmptyCopyWithImpl<T, BaseStateEmpty<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseStateEmpty<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BaseState<$T>.empty(message: $message)';
}


}

/// @nodoc
abstract mixin class $BaseStateEmptyCopyWith<T,$Res> implements $BaseStateCopyWith<T, $Res> {
  factory $BaseStateEmptyCopyWith(BaseStateEmpty<T> value, $Res Function(BaseStateEmpty<T>) _then) = _$BaseStateEmptyCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$BaseStateEmptyCopyWithImpl<T,$Res>
    implements $BaseStateEmptyCopyWith<T, $Res> {
  _$BaseStateEmptyCopyWithImpl(this._self, this._then);

  final BaseStateEmpty<T> _self;
  final $Res Function(BaseStateEmpty<T>) _then;

/// Create a copy of BaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(BaseStateEmpty<T>(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
