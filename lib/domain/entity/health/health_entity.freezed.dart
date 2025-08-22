// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HealthEntity {

 int get steps; int get heartRate; String get bloodPressure;
/// Create a copy of HealthEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthEntityCopyWith<HealthEntity> get copyWith => _$HealthEntityCopyWithImpl<HealthEntity>(this as HealthEntity, _$identity);

  /// Serializes this HealthEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthEntity&&(identical(other.steps, steps) || other.steps == steps)&&(identical(other.heartRate, heartRate) || other.heartRate == heartRate)&&(identical(other.bloodPressure, bloodPressure) || other.bloodPressure == bloodPressure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,steps,heartRate,bloodPressure);

@override
String toString() {
  return 'HealthEntity(steps: $steps, heartRate: $heartRate, bloodPressure: $bloodPressure)';
}


}

/// @nodoc
abstract mixin class $HealthEntityCopyWith<$Res>  {
  factory $HealthEntityCopyWith(HealthEntity value, $Res Function(HealthEntity) _then) = _$HealthEntityCopyWithImpl;
@useResult
$Res call({
 int steps, int heartRate, String bloodPressure
});




}
/// @nodoc
class _$HealthEntityCopyWithImpl<$Res>
    implements $HealthEntityCopyWith<$Res> {
  _$HealthEntityCopyWithImpl(this._self, this._then);

  final HealthEntity _self;
  final $Res Function(HealthEntity) _then;

/// Create a copy of HealthEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? steps = null,Object? heartRate = null,Object? bloodPressure = null,}) {
  return _then(_self.copyWith(
steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as int,heartRate: null == heartRate ? _self.heartRate : heartRate // ignore: cast_nullable_to_non_nullable
as int,bloodPressure: null == bloodPressure ? _self.bloodPressure : bloodPressure // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HealthEntity].
extension HealthEntityPatterns on HealthEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HealthEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HealthEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HealthEntity value)  $default,){
final _that = this;
switch (_that) {
case _HealthEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HealthEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HealthEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int steps,  int heartRate,  String bloodPressure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthEntity() when $default != null:
return $default(_that.steps,_that.heartRate,_that.bloodPressure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int steps,  int heartRate,  String bloodPressure)  $default,) {final _that = this;
switch (_that) {
case _HealthEntity():
return $default(_that.steps,_that.heartRate,_that.bloodPressure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int steps,  int heartRate,  String bloodPressure)?  $default,) {final _that = this;
switch (_that) {
case _HealthEntity() when $default != null:
return $default(_that.steps,_that.heartRate,_that.bloodPressure);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HealthEntity implements HealthEntity {
  const _HealthEntity({required this.steps, required this.heartRate, required this.bloodPressure});
  factory _HealthEntity.fromJson(Map<String, dynamic> json) => _$HealthEntityFromJson(json);

@override final  int steps;
@override final  int heartRate;
@override final  String bloodPressure;

/// Create a copy of HealthEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthEntityCopyWith<_HealthEntity> get copyWith => __$HealthEntityCopyWithImpl<_HealthEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HealthEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthEntity&&(identical(other.steps, steps) || other.steps == steps)&&(identical(other.heartRate, heartRate) || other.heartRate == heartRate)&&(identical(other.bloodPressure, bloodPressure) || other.bloodPressure == bloodPressure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,steps,heartRate,bloodPressure);

@override
String toString() {
  return 'HealthEntity(steps: $steps, heartRate: $heartRate, bloodPressure: $bloodPressure)';
}


}

/// @nodoc
abstract mixin class _$HealthEntityCopyWith<$Res> implements $HealthEntityCopyWith<$Res> {
  factory _$HealthEntityCopyWith(_HealthEntity value, $Res Function(_HealthEntity) _then) = __$HealthEntityCopyWithImpl;
@override @useResult
$Res call({
 int steps, int heartRate, String bloodPressure
});




}
/// @nodoc
class __$HealthEntityCopyWithImpl<$Res>
    implements _$HealthEntityCopyWith<$Res> {
  __$HealthEntityCopyWithImpl(this._self, this._then);

  final _HealthEntity _self;
  final $Res Function(_HealthEntity) _then;

/// Create a copy of HealthEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? steps = null,Object? heartRate = null,Object? bloodPressure = null,}) {
  return _then(_HealthEntity(
steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as int,heartRate: null == heartRate ? _self.heartRate : heartRate // ignore: cast_nullable_to_non_nullable
as int,bloodPressure: null == bloodPressure ? _self.bloodPressure : bloodPressure // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
