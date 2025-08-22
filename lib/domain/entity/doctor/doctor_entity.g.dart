// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoctorEntity _$DoctorEntityFromJson(Map<String, dynamic> json) =>
    _DoctorEntity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      position: json['position'] as String,
      mobile: json['mobile'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$DoctorEntityToJson(_DoctorEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': instance.position,
      'mobile': instance.mobile,
      'image': instance.image,
    };
