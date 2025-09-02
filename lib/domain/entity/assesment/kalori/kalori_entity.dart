import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_data_entity.dart';

part 'kalori_entity.g.dart';
part 'kalori_entity.freezed.dart';

@freezed
abstract class KaloriEntity with _$KaloriEntity {
  const factory KaloriEntity({
    required String type,
    required String total,
    List<ItemDataEntity>? data,
    String? date,
    String? name,
    int? targetKalori,
  }) = _KaloriEntity;

  factory KaloriEntity.fromJson(Map<String, dynamic> json) =>
      _$KaloriEntityFromJson(json);
}
