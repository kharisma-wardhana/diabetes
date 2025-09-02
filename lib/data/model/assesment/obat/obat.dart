import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entity/assesment/obat_entity.dart';

part 'obat.freezed.dart';
part 'obat.g.dart';

@freezed
abstract class Obat with _$Obat {
  const Obat._();

  factory Obat({
    required int id,
    @JsonKey(name: 'users_id') required String usersId,
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'nama') required String name,
    required String dosis,
    required int type,
    int? status,
  }) = _Obat;

  factory Obat.fromJson(Map<String, dynamic> json) => _$ObatFromJson(json);

  ObatEntity toEntity() => ObatEntity(
    id: id,
    usersId: int.parse(usersId),
    date: date,
    name: name,
    dosis: dosis,
    type: type,
    status: status,
  );
}
