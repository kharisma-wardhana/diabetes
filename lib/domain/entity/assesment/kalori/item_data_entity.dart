import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_data_entity.g.dart';
part 'item_data_entity.freezed.dart';

@freezed
abstract class ItemDataEntity with _$ItemDataEntity {
  const ItemDataEntity._();
  const factory ItemDataEntity({
    required int id,
    required String name,
    required int total,
  }) = _ItemDataEntity;

  factory ItemDataEntity.fromJson(Map<String, dynamic> json) =>
      _$ItemDataEntityFromJson(json);
}
