import 'package:freezed_annotation/freezed_annotation.dart';

part 'antropometri_entity.freezed.dart';
part 'antropometri_entity.g.dart';

@freezed
abstract class AntropometriEntity with _$AntropometriEntity {
  const factory AntropometriEntity({
    int? id,
    required double height,
    required double weight,
    required double stomach,
    required double hand,
    required double result,
    required String status,
    String? activity,
    String? waistStatus,
    String? armStatus,
    int? diabetesType,
  }) = _AntropometriEntity;

  factory AntropometriEntity.fromJson(Map<String, dynamic> json) =>
      _$AntropometriEntityFromJson(json);
}
