// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Video _$VideoFromJson(Map<String, dynamic> json) => _Video(
  id: (json['id'] as num).toInt(),
  title: json['judul'] as String,
  desc: json['desc'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$VideoToJson(_Video instance) => <String, dynamic>{
  'id': instance.id,
  'judul': instance.title,
  'desc': instance.desc,
  'url': instance.url,
};
