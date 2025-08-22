// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Article _$ArticleFromJson(Map<String, dynamic> json) => _Article(
  id: (json['id'] as num).toInt(),
  title: json['judul'] as String,
  content: json['content'] as String,
  image: json['image'] as String?,
  audio: json['audio'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$ArticleToJson(_Article instance) => <String, dynamic>{
  'id': instance.id,
  'judul': instance.title,
  'content': instance.content,
  'image': instance.image,
  'audio': instance.audio,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
