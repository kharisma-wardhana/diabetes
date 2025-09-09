import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entity/assesment/kolesterol_entity.dart';

part 'kolesterol.freezed.dart';
part 'kolesterol.g.dart';

@freezed
abstract class Kolesterol with _$Kolesterol {
  const Kolesterol._();
  factory Kolesterol({
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'kadar_kolesterol') required String total,
  }) = _Kolesterol;

  factory Kolesterol.fromJson(Map<String, dynamic> json) =>
      _$KolesterolFromJson(json);

  KolesterolEntity toEntity() {
    String titleType = 'LDL';
    if (type == '1') {
      titleType = 'HDL';
    } else if (type == '2') {
      titleType = 'Trigliserida';
    } else if (type == '3') {
      titleType = 'Total';
    }
    return KolesterolEntity(
      date: date,
      type: titleType,
      total: int.parse(total),
    );
  }
}
