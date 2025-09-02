import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entity/assesment/kalori/item_data_entity.dart';

part 'item_data.freezed.dart';
part 'item_data.g.dart';

@freezed
abstract class ItemData with _$ItemData {
  const ItemData._();

  factory ItemData({
    required int id,
    @JsonKey(name: 'nama') required String name,
    @JsonKey(name: 'jumlah_kalori') required int total,
  }) = _ItemData;

  factory ItemData.fromJson(Map<String, dynamic> json) =>
      _$ItemDataFromJson(json);

  ItemDataEntity toEntity() => ItemDataEntity(id: id, name: name, total: total);
}
