// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticleEntity _$ArticleEntityFromJson(Map<String, dynamic> json) =>
    _ArticleEntity(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['image'] as String?,
      audio: json['audio'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ArticleEntityToJson(_ArticleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'audio': instance.audio,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
