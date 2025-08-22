import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_entity.freezed.dart';
part 'article_entity.g.dart';

@freezed
abstract class ArticleEntity with _$ArticleEntity {
  const factory ArticleEntity({
    required int id,
    required String title,
    required String content,
    String? image,
    String? audio,
    required String createdAt,
    required String updatedAt,
  }) = _ArticleEntity;

  factory ArticleEntity.fromJson(Map<String, dynamic> json) =>
      _$ArticleEntityFromJson(json);
}
