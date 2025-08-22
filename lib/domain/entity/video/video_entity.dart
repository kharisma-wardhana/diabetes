import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_entity.freezed.dart';
part 'video_entity.g.dart';

@freezed
abstract class VideoEntity with _$VideoEntity {
  const factory VideoEntity({
    required String title,
    required String desc,
    required String url,
  }) = _VideoEntity;

  factory VideoEntity.fromJson(Map<String, dynamic> json) =>
      _$VideoEntityFromJson(json);
}
