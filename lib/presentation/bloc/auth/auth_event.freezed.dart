// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RegisterEvent value)?  register,TResult Function( LoginEvent value)?  login,TResult Function( LogoutEvent value)?  logout,TResult Function( AppStarted value)?  appStarted,TResult Function( CompleteOnboardingEvent value)?  completeOnboarding,TResult Function( CompleteAntropometriEvent value)?  completeAntropometri,TResult Function( UpdateTypeDiabetesEvent value)?  updateTypeDiabetes,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RegisterEvent() when register != null:
return register(_that);case LoginEvent() when login != null:
return login(_that);case LogoutEvent() when logout != null:
return logout(_that);case AppStarted() when appStarted != null:
return appStarted(_that);case CompleteOnboardingEvent() when completeOnboarding != null:
return completeOnboarding(_that);case CompleteAntropometriEvent() when completeAntropometri != null:
return completeAntropometri(_that);case UpdateTypeDiabetesEvent() when updateTypeDiabetes != null:
return updateTypeDiabetes(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RegisterEvent value)  register,required TResult Function( LoginEvent value)  login,required TResult Function( LogoutEvent value)  logout,required TResult Function( AppStarted value)  appStarted,required TResult Function( CompleteOnboardingEvent value)  completeOnboarding,required TResult Function( CompleteAntropometriEvent value)  completeAntropometri,required TResult Function( UpdateTypeDiabetesEvent value)  updateTypeDiabetes,}){
final _that = this;
switch (_that) {
case RegisterEvent():
return register(_that);case LoginEvent():
return login(_that);case LogoutEvent():
return logout(_that);case AppStarted():
return appStarted(_that);case CompleteOnboardingEvent():
return completeOnboarding(_that);case CompleteAntropometriEvent():
return completeAntropometri(_that);case UpdateTypeDiabetesEvent():
return updateTypeDiabetes(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RegisterEvent value)?  register,TResult? Function( LoginEvent value)?  login,TResult? Function( LogoutEvent value)?  logout,TResult? Function( AppStarted value)?  appStarted,TResult? Function( CompleteOnboardingEvent value)?  completeOnboarding,TResult? Function( CompleteAntropometriEvent value)?  completeAntropometri,TResult? Function( UpdateTypeDiabetesEvent value)?  updateTypeDiabetes,}){
final _that = this;
switch (_that) {
case RegisterEvent() when register != null:
return register(_that);case LoginEvent() when login != null:
return login(_that);case LogoutEvent() when logout != null:
return logout(_that);case AppStarted() when appStarted != null:
return appStarted(_that);case CompleteOnboardingEvent() when completeOnboarding != null:
return completeOnboarding(_that);case CompleteAntropometriEvent() when completeAntropometri != null:
return completeAntropometri(_that);case UpdateTypeDiabetesEvent() when updateTypeDiabetes != null:
return updateTypeDiabetes(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  String email,  String mobile,  String dob,  String gender)?  register,TResult Function( String username,  String password)?  login,TResult Function()?  logout,TResult Function()?  appStarted,TResult Function()?  completeOnboarding,TResult Function()?  completeAntropometri,TResult Function( int typeDiabetes)?  updateTypeDiabetes,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RegisterEvent() when register != null:
return register(_that.name,_that.email,_that.mobile,_that.dob,_that.gender);case LoginEvent() when login != null:
return login(_that.username,_that.password);case LogoutEvent() when logout != null:
return logout();case AppStarted() when appStarted != null:
return appStarted();case CompleteOnboardingEvent() when completeOnboarding != null:
return completeOnboarding();case CompleteAntropometriEvent() when completeAntropometri != null:
return completeAntropometri();case UpdateTypeDiabetesEvent() when updateTypeDiabetes != null:
return updateTypeDiabetes(_that.typeDiabetes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  String email,  String mobile,  String dob,  String gender)  register,required TResult Function( String username,  String password)  login,required TResult Function()  logout,required TResult Function()  appStarted,required TResult Function()  completeOnboarding,required TResult Function()  completeAntropometri,required TResult Function( int typeDiabetes)  updateTypeDiabetes,}) {final _that = this;
switch (_that) {
case RegisterEvent():
return register(_that.name,_that.email,_that.mobile,_that.dob,_that.gender);case LoginEvent():
return login(_that.username,_that.password);case LogoutEvent():
return logout();case AppStarted():
return appStarted();case CompleteOnboardingEvent():
return completeOnboarding();case CompleteAntropometriEvent():
return completeAntropometri();case UpdateTypeDiabetesEvent():
return updateTypeDiabetes(_that.typeDiabetes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  String email,  String mobile,  String dob,  String gender)?  register,TResult? Function( String username,  String password)?  login,TResult? Function()?  logout,TResult? Function()?  appStarted,TResult? Function()?  completeOnboarding,TResult? Function()?  completeAntropometri,TResult? Function( int typeDiabetes)?  updateTypeDiabetes,}) {final _that = this;
switch (_that) {
case RegisterEvent() when register != null:
return register(_that.name,_that.email,_that.mobile,_that.dob,_that.gender);case LoginEvent() when login != null:
return login(_that.username,_that.password);case LogoutEvent() when logout != null:
return logout();case AppStarted() when appStarted != null:
return appStarted();case CompleteOnboardingEvent() when completeOnboarding != null:
return completeOnboarding();case CompleteAntropometriEvent() when completeAntropometri != null:
return completeAntropometri();case UpdateTypeDiabetesEvent() when updateTypeDiabetes != null:
return updateTypeDiabetes(_that.typeDiabetes);case _:
  return null;

}
}

}

/// @nodoc


class RegisterEvent implements AuthEvent {
  const RegisterEvent({required this.name, required this.email, required this.mobile, required this.dob, required this.gender});
  

 final  String name;
 final  String email;
 final  String mobile;
 final  String dob;
 final  String gender;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterEventCopyWith<RegisterEvent> get copyWith => _$RegisterEventCopyWithImpl<RegisterEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterEvent&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,mobile,dob,gender);

@override
String toString() {
  return 'AuthEvent.register(name: $name, email: $email, mobile: $mobile, dob: $dob, gender: $gender)';
}


}

/// @nodoc
abstract mixin class $RegisterEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $RegisterEventCopyWith(RegisterEvent value, $Res Function(RegisterEvent) _then) = _$RegisterEventCopyWithImpl;
@useResult
$Res call({
 String name, String email, String mobile, String dob, String gender
});




}
/// @nodoc
class _$RegisterEventCopyWithImpl<$Res>
    implements $RegisterEventCopyWith<$Res> {
  _$RegisterEventCopyWithImpl(this._self, this._then);

  final RegisterEvent _self;
  final $Res Function(RegisterEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? mobile = null,Object? dob = null,Object? gender = null,}) {
  return _then(RegisterEvent(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoginEvent implements AuthEvent {
  const LoginEvent({required this.username, required this.password});
  

 final  String username;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginEventCopyWith<LoginEvent> get copyWith => _$LoginEventCopyWithImpl<LoginEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,username,password);

@override
String toString() {
  return 'AuthEvent.login(username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $LoginEventCopyWith(LoginEvent value, $Res Function(LoginEvent) _then) = _$LoginEventCopyWithImpl;
@useResult
$Res call({
 String username, String password
});




}
/// @nodoc
class _$LoginEventCopyWithImpl<$Res>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._self, this._then);

  final LoginEvent _self;
  final $Res Function(LoginEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,}) {
  return _then(LoginEvent(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LogoutEvent implements AuthEvent {
  const LogoutEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logout()';
}


}




/// @nodoc


class AppStarted implements AuthEvent {
  const AppStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.appStarted()';
}


}




/// @nodoc


class CompleteOnboardingEvent implements AuthEvent {
  const CompleteOnboardingEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteOnboardingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.completeOnboarding()';
}


}




/// @nodoc


class CompleteAntropometriEvent implements AuthEvent {
  const CompleteAntropometriEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteAntropometriEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.completeAntropometri()';
}


}




/// @nodoc


class UpdateTypeDiabetesEvent implements AuthEvent {
  const UpdateTypeDiabetesEvent(this.typeDiabetes);
  

 final  int typeDiabetes;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTypeDiabetesEventCopyWith<UpdateTypeDiabetesEvent> get copyWith => _$UpdateTypeDiabetesEventCopyWithImpl<UpdateTypeDiabetesEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTypeDiabetesEvent&&(identical(other.typeDiabetes, typeDiabetes) || other.typeDiabetes == typeDiabetes));
}


@override
int get hashCode => Object.hash(runtimeType,typeDiabetes);

@override
String toString() {
  return 'AuthEvent.updateTypeDiabetes(typeDiabetes: $typeDiabetes)';
}


}

/// @nodoc
abstract mixin class $UpdateTypeDiabetesEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $UpdateTypeDiabetesEventCopyWith(UpdateTypeDiabetesEvent value, $Res Function(UpdateTypeDiabetesEvent) _then) = _$UpdateTypeDiabetesEventCopyWithImpl;
@useResult
$Res call({
 int typeDiabetes
});




}
/// @nodoc
class _$UpdateTypeDiabetesEventCopyWithImpl<$Res>
    implements $UpdateTypeDiabetesEventCopyWith<$Res> {
  _$UpdateTypeDiabetesEventCopyWithImpl(this._self, this._then);

  final UpdateTypeDiabetesEvent _self;
  final $Res Function(UpdateTypeDiabetesEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? typeDiabetes = null,}) {
  return _then(UpdateTypeDiabetesEvent(
null == typeDiabetes ? _self.typeDiabetes : typeDiabetes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
