import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/user/user_entity.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const User._();
  const factory User({
    required int id,
    required String name,
    required String mobile,
    required String email,
    required String gender,
    required String dob,
    int? age,
    int? typeDiabetes,
    String? token,
    bool? isOnboardingComplete,
    bool? isAntropometriComplete,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Mapping to domain entity
  UserEntity toEntity() => UserEntity(
    id: id,
    name: name,
    email: email,
    mobile: mobile,
    gender: gender,
    dob: dob,
    age: age,
    typeDiabetes: typeDiabetes,
    token: token,
    isOnboardingComplete: isOnboardingComplete ?? false,
    isAntropometriComplete: isAntropometriComplete ?? false,
  );
}
