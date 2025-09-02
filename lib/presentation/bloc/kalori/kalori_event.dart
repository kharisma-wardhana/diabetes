import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/assesment/kalori/kalori_entity.dart';

part 'kalori_event.freezed.dart';

@freezed
class KaloriEvent with _$KaloriEvent {
  const factory KaloriEvent.started(int targetKalori) = KaloriStarted;
  const factory KaloriEvent.fetched(String date) = KaloriFetched;
  const factory KaloriEvent.addNutrition(KaloriEntity kalori) =
      KaloriAddNutrition;
  const factory KaloriEvent.updated(KaloriEntity kalori) = KaloriUpdated;
  const factory KaloriEvent.deleted(String id) = KaloriDeleted;
  const factory KaloriEvent.loadCachedData() = LoadCachedData;
  const factory KaloriEvent.clearCache() = ClearCache;
}
