// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  mobile: json['mobile'] as String,
  email: json['email'] as String,
  gender: json['gender'] as String,
  dob: json['dob'] as String,
  age: (json['age'] as num?)?.toInt(),
  typeDiabetes: (json['typeDiabetes'] as num?)?.toInt(),
  token: json['token'] as String?,
  isOnboardingComplete: json['isOnboardingComplete'] as bool?,
  isAntropometriComplete: json['isAntropometriComplete'] as bool?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'mobile': instance.mobile,
  'email': instance.email,
  'gender': instance.gender,
  'dob': instance.dob,
  'age': instance.age,
  'typeDiabetes': instance.typeDiabetes,
  'token': instance.token,
  'isOnboardingComplete': instance.isOnboardingComplete,
  'isAntropometriComplete': instance.isAntropometriComplete,
};
