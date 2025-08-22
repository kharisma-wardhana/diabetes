// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 int get id; String get name; String get mobile; String get email; String get gender; String get dob; String? get token; bool? get isOnboardingComplete; bool? get isAntropometriComplete;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.token, token) || other.token == token)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete)&&(identical(other.isAntropometriComplete, isAntropometriComplete) || other.isAntropometriComplete == isAntropometriComplete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,mobile,email,gender,dob,token,isOnboardingComplete,isAntropometriComplete);

@override
String toString() {
  return 'User(id: $id, name: $name, mobile: $mobile, email: $email, gender: $gender, dob: $dob, token: $token, isOnboardingComplete: $isOnboardingComplete, isAntropometriComplete: $isAntropometriComplete)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 int id, String name, String mobile, String email, String gender, String dob, String? token, bool? isOnboardingComplete, bool? isAntropometriComplete
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? mobile = null,Object? email = null,Object? gender = null,Object? dob = null,Object? token = freezed,Object? isOnboardingComplete = freezed,Object? isAntropometriComplete = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,isOnboardingComplete: freezed == isOnboardingComplete ? _self.isOnboardingComplete : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
as bool?,isAntropometriComplete: freezed == isAntropometriComplete ? _self.isAntropometriComplete : isAntropometriComplete // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String mobile,  String email,  String gender,  String dob,  String? token,  bool? isOnboardingComplete,  bool? isAntropometriComplete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.name,_that.mobile,_that.email,_that.gender,_that.dob,_that.token,_that.isOnboardingComplete,_that.isAntropometriComplete);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String mobile,  String email,  String gender,  String dob,  String? token,  bool? isOnboardingComplete,  bool? isAntropometriComplete)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.name,_that.mobile,_that.email,_that.gender,_that.dob,_that.token,_that.isOnboardingComplete,_that.isAntropometriComplete);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String mobile,  String email,  String gender,  String dob,  String? token,  bool? isOnboardingComplete,  bool? isAntropometriComplete)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.name,_that.mobile,_that.email,_that.gender,_that.dob,_that.token,_that.isOnboardingComplete,_that.isAntropometriComplete);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({required this.id, required this.name, required this.mobile, required this.email, required this.gender, required this.dob, this.token, this.isOnboardingComplete, this.isAntropometriComplete}): super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  int id;
@override final  String name;
@override final  String mobile;
@override final  String email;
@override final  String gender;
@override final  String dob;
@override final  String? token;
@override final  bool? isOnboardingComplete;
@override final  bool? isAntropometriComplete;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.email, email) || other.email == email)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.token, token) || other.token == token)&&(identical(other.isOnboardingComplete, isOnboardingComplete) || other.isOnboardingComplete == isOnboardingComplete)&&(identical(other.isAntropometriComplete, isAntropometriComplete) || other.isAntropometriComplete == isAntropometriComplete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,mobile,email,gender,dob,token,isOnboardingComplete,isAntropometriComplete);

@override
String toString() {
  return 'User(id: $id, name: $name, mobile: $mobile, email: $email, gender: $gender, dob: $dob, token: $token, isOnboardingComplete: $isOnboardingComplete, isAntropometriComplete: $isAntropometriComplete)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String mobile, String email, String gender, String dob, String? token, bool? isOnboardingComplete, bool? isAntropometriComplete
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? mobile = null,Object? email = null,Object? gender = null,Object? dob = null,Object? token = freezed,Object? isOnboardingComplete = freezed,Object? isAntropometriComplete = freezed,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
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
