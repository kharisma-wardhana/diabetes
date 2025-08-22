// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserEntity {

 int get id; String get name; String get email; String get mobile; String get gender; String get dob; String? get token; bool? get isOnboardingComplete; bool? get isAntropometriComplete;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);

  /// Serializes this UserEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.token, token) || other.token == token)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete)&&(identical(other.isAntropometriComplete, isAntropometriComplete) || other.isAntropometriComplete == isAntropometriComplete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,mobile,gender,dob,token,isOnboardingComplete,isAntropometriComplete);

@override
String toString() {
  return 'UserEntity(id: $id, name: $name, email: $email, mobile: $mobile, gender: $gender, dob: $dob, token: $token, isOnboardingComplete: $isOnboardingComplete, isAntropometriComplete: $isAntropometriComplete)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String email, String mobile, String gender, String dob, String? token, bool? isOnboardingComplete, bool? isAntropometriComplete
});




}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? mobile = null,Object? gender = null,Object? dob = null,Object? token = freezed,Object? isOnboardingComplete = freezed,Object? isAntropometriComplete = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,isOnboardingComplete: freezed == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool?,isAntropometriComplete: freezed == isAntropometriComplete ? _self.isAntropometriComplete : isAntropometriComplete // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String email,  String mobile,  String gender,  String dob,  String? token,  bool? isOnboardingComplete,  bool? isAntropometriComplete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.mobile,_that.gender,_that.dob,_that.token,_that.isOnboardingComplete,_that.isAntropometriComplete);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String email,  String mobile,  String gender,  String dob,  String? token,  bool? isOnboardingComplete,  bool? isAntropometriComplete)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.id,_that.name,_that.email,_that.mobile,_that.gender,_that.dob,_that.token,_that.isOnboardingComplete,_that.isAntropometriComplete);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String email,  String mobile,  String gender,  String dob,  String? token,  bool? isOnboardingComplete,  bool? isAntropometriComplete)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.mobile,_that.gender,_that.dob,_that.token,_that.isOnboardingComplete,_that.isAntropometriComplete);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserEntity implements UserEntity {
  const _UserEntity({required this.id, required this.name, required this.email, required this.mobile, required this.gender, required this.dob, this.token, this.isOnboardingComplete, this.isAntropometriComplete});
  factory _UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

@override final  int id;
@override final  String name;
@override final  String email;
@override final  String mobile;
@override final  String gender;
@override final  String dob;
@override final  String? token;
@override final  bool? isOnboardingComplete;
@override final  bool? isAntropometriComplete;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.token, token) || other.token == token)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete)&&(identical(other.isAntropometriComplete, isAntropometriComplete) || other.isAntropometriComplete == isAntropometriComplete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,mobile,gender,dob,token,isOnboardingComplete,isAntropometriComplete);

@override
String toString() {
  return 'UserEntity(id: $id, name: $name, email: $email, mobile: $mobile, gender: $gender, dob: $dob, token: $token, isOnboardingComplete: $isOnboardingComplete, isAntropometriComplete: $isAntropometriComplete)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String email, String mobile, String gender, String dob, String? token, bool? isOnboardingComplete, bool? isAntropometriComplete
});




}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? mobile = null,Object? gender = null,Object? dob = null,Object? token = freezed,Object? isOnboardingComplete = freezed,Object? isAntropometriComplete = freezed,}) {
  return _then(_UserEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,isOnboardingComplete: freezed == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool?,isAntropometriComplete: freezed == isAntropometriComplete ? _self.isAntropometriComplete : isAntropometriComplete // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
