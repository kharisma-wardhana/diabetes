// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoctorEntity {

 int get id; String get name; String get position; String get mobile; String get image;
/// Create a copy of DoctorEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorEntityCopyWith<DoctorEntity> get copyWith => _$DoctorEntityCopyWithImpl<DoctorEntity>(this as DoctorEntity, _$identity);

  /// Serializes this DoctorEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,position,mobile,image);

@override
String toString() {
  return 'DoctorEntity(id: $id, name: $name, position: $position, mobile: $mobile, image: $image)';
}


}

/// @nodoc
abstract mixin class $DoctorEntityCopyWith<$Res>  {
  factory $DoctorEntityCopyWith(DoctorEntity value, $Res Function(DoctorEntity) _then) = _$DoctorEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String position, String mobile, String image
});




}
/// @nodoc
class _$DoctorEntityCopyWithImpl<$Res>
    implements $DoctorEntityCopyWith<$Res> {
  _$DoctorEntityCopyWithImpl(this._self, this._then);

  final DoctorEntity _self;
  final $Res Function(DoctorEntity) _then;

/// Create a copy of DoctorEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? position = null,Object? mobile = null,Object? image = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DoctorEntity].
extension DoctorEntityPatterns on DoctorEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoctorEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoctorEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoctorEntity value)  $default,){
final _that = this;
switch (_that) {
case _DoctorEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoctorEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DoctorEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String position,  String mobile,  String image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoctorEntity() when $default != null:
return $default(_that.id,_that.name,_that.position,_that.mobile,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String position,  String mobile,  String image)  $default,) {final _that = this;
switch (_that) {
case _DoctorEntity():
return $default(_that.id,_that.name,_that.position,_that.mobile,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String position,  String mobile,  String image)?  $default,) {final _that = this;
switch (_that) {
case _DoctorEntity() when $default != null:
return $default(_that.id,_that.name,_that.position,_that.mobile,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoctorEntity implements DoctorEntity {
  const _DoctorEntity({required this.id, required this.name, required this.position, required this.mobile, required this.image});
  factory _DoctorEntity.fromJson(Map<String, dynamic> json) => _$DoctorEntityFromJson(json);

@override final  int id;
@override final  String name;
@override final  String position;
@override final  String mobile;
@override final  String image;

/// Create a copy of DoctorEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorEntityCopyWith<_DoctorEntity> get copyWith => __$DoctorEntityCopyWithImpl<_DoctorEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoctorEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoctorEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,position,mobile,image);

@override
String toString() {
  return 'DoctorEntity(id: $id, name: $name, position: $position, mobile: $mobile, image: $image)';
}


}

/// @nodoc
abstract mixin class _$DoctorEntityCopyWith<$Res> implements $DoctorEntityCopyWith<$Res> {
  factory _$DoctorEntityCopyWith(_DoctorEntity value, $Res Function(_DoctorEntity) _then) = __$DoctorEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String position, String mobile, String image
});




}
/// @nodoc
class __$DoctorEntityCopyWithImpl<$Res>
    implements _$DoctorEntityCopyWith<$Res> {
  __$DoctorEntityCopyWithImpl(this._self, this._then);

  final _DoctorEntity _self;
  final $Res Function(_DoctorEntity) _then;

/// Create a copy of DoctorEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? position = null,Object? mobile = null,Object? image = null,}) {
  return _then(_DoctorEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
