import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entity/assesment/kalori/kalori_entity.dart';
import 'item_data.dart';

part 'kalori.freezed.dart';
part 'kalori.g.dart';

@freezed
abstract class Kalori with _$Kalori {
  const Kalori._();

  factory Kalori({
    required int type,
    required String total,
    required List<ItemData> data,
  }) = _Kalori;

  factory Kalori.fromJson(Map<String, dynamic> json) => _$KaloriFromJson(json);

  KaloriEntity toEntity() => KaloriEntity(
    type: type.toString(),
    total: total,
    data: data.map((item) => item.toEntity()).toList(),
  );
}
