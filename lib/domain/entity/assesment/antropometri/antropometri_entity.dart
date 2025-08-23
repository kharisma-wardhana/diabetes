import 'package:freezed_annotation/freezed_annotation.dart';

part 'antropometri_entity.freezed.dart';
part 'antropometri_entity.g.dart';

@freezed
abstract class AntropometriEntity with _$AntropometriEntity {
  const factory AntropometriEntity({
    required double height,
    required double weight,
    required double stomach,
    required double hand,
    required double result,
    required String status,
    String? activity,
    String? waistStatus,
    String? armStatus,
  }) = _AntropometriEntity;

  factory AntropometriEntity.fromJson(Map<String, dynamic> json) =>
      _$AntropometriEntityFromJson(json);
}
