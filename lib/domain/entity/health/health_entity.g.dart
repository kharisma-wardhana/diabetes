// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HealthEntity _$HealthEntityFromJson(Map<String, dynamic> json) =>
    _HealthEntity(
      steps: (json['steps'] as num).toInt(),
      heartRate: (json['heartRate'] as num).toInt(),
      bloodPressure: json['bloodPressure'] as String,
      kaloriBurned: (json['kaloriBurned'] as num).toDouble(),
      bloodSugar: (json['bloodSugar'] as num?)?.toInt(),
      stepGoal: (json['stepGoal'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HealthEntityToJson(_HealthEntity instance) =>
    <String, dynamic>{
      'steps': instance.steps,
      'heartRate': instance.heartRate,
      'bloodPressure': instance.bloodPressure,
      'kaloriBurned': instance.kaloriBurned,
      'bloodSugar': instance.bloodSugar,
      'stepGoal': instance.stepGoal,
    };
