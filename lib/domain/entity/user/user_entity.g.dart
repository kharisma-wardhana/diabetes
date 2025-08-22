// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => _UserEntity(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  mobile: json['mobile'] as String,
  gender: json['gender'] as String,
  dob: json['dob'] as String,
  token: json['token'] as String?,
  isOnboardingComplete: json['isOnboardingComplete'] as bool?,
  isAntropometriComplete: json['isAntropometriComplete'] as bool?,
);

Map<String, dynamic> _$UserEntityToJson(_UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'gender': instance.gender,
      'dob': instance.dob,
      'token': instance.token,
      'isOnboardingComplete': instance.isOnboardingComplete,
      'isAntropometriComplete': instance.isAntropometriComplete,
    };
