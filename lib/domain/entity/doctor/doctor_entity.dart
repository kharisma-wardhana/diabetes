import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_entity.freezed.dart';
part 'doctor_entity.g.dart';

@freezed
abstract class DoctorEntity with _$DoctorEntity {
  const factory DoctorEntity({
    required int id,
    required String name,
    required String position,
    required String mobile,
    required String image,
  }) = _DoctorEntity;

  factory DoctorEntity.fromJson(Map<String, dynamic> json) =>
      _$DoctorEntityFromJson(json);
}
