// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Doctor _$DoctorFromJson(Map<String, dynamic> json) => _Doctor(
  id: (json['id'] as num).toInt(),
  name: json['nama'] as String,
  position: json['posisi'] as String,
  mobile: json['wa'] as String,
  image: json['foto'] as String,
);

Map<String, dynamic> _$DoctorToJson(_Doctor instance) => <String, dynamic>{
  'id': instance.id,
  'nama': instance.name,
  'posisi': instance.position,
  'wa': instance.mobile,
  'foto': instance.image,
};
