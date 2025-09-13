import 'dart:convert';

import 'package:diabetes/core/constant.dart';
import 'package:diabetes/core/usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/base_state.dart';
import '../../../core/injector/service_locator.dart';
import '../../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../../domain/usecase/nutrition/add_nutrition_usecase.dart';
import '../../../domain/usecase/nutrition/get_list_nutrition_usecase.dart';
import 'kalori_event.dart';

class KaloriBloc extends Bloc<KaloriEvent, BaseState<KaloriEntity>> {
  final AddNutritionUseCase addNutritionUseCase;
  final GetListNutritionUseCase getListNutritionUseCase;
  final FlutterSecureStorage secureStorage;

  // Storage keys
  static const String _kaloriDataKey = 'kalori_data';

  KaloriBloc({
    required this.addNutritionUseCase,
    required this.getListNutritionUseCase,
    required this.secureStorage,
  }) : super(BaseState.initial()) {
    on<KaloriStarted>(_startedNutrition);
    on<KaloriFetched>(_getAllNutrition);
    on<KaloriAddNutrition>(_addNutrition);
    on<LoadCachedData>(_onLoadCachedData);
    on<ClearCache>(_onClearCache);
    _loadPersistedState();
  }

  // Persistence methods
  Future<void> _loadPersistedState() async {
    try {
      // Check if we have cached kalori data and trigger loading if found
      final kaloriDataJson = await secureStorage.read(key: _kaloriDataKey);
      if (kaloriDataJson != null) {
        // Add an event to load the cached data
        add(const LoadCachedData());
      }
    } catch (e) {
      if (kDebugMode) {
        // If there's an error loading persisted state, continue with initial state
        print('Error loading persisted state: $e');
      }
    }
  }

  Future<void> _onLoadCachedData(
    LoadCachedData event,
    Emitter<BaseState<KaloriEntity>> emit,
  ) async {
    try {
      final kaloriDataJson = await secureStorage.read(key: _kaloriDataKey);
      if (kaloriDataJson != null) {
        final data = KaloriEntity.fromJson(jsonDecode(kaloriDataJson));
        emit(
          BaseState.success(data: data, message: 'Loaded cached kalori data'),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading cached data: $e');
      }
      // If error loading cache, proceed with fresh data fetch
      add(KaloriEvent.fetched(DateTime.now().toIso8601String().split('T')[0]));
    }
  }

  Future<void> _onClearCache(
    ClearCache event,
    Emitter<BaseState<KaloriEntity>> emit,
  ) async {
    await _clearPersistedData();
    emit(const BaseState.initial());
  }

  Future<void> _clearPersistedData() async {
    try {
      await secureStorage.delete(key: _kaloriDataKey);
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing persisted data: $e');
      }
    }
  }

  void _startedNutrition(
    KaloriStarted event,
    Emitter<BaseState<KaloriEntity>> emit,
  ) async {
    final kalori = KaloriEntity(
      type: '',
      total: '0',
      date: DateTime.now().toIso8601String().split('T')[0],
      targetKalori: event.targetKalori,
    );
    // Persistent started data
    secureStorage.write(
      key: _kaloriDataKey,
      value: jsonEncode(kalori.toJson()),
    );
    emit(BaseState.success(data: kalori));
  }

  Future<void> _getAllNutrition(
    KaloriFetched event,
    Emitter<BaseState<KaloriEntity>> emit,
  ) async {
    emit(BaseState.loading());
    final result = await getListNutritionUseCase.call(
      SearchParams(date: event.date),
    );
    result.fold(
      (failure) =>
          emit(BaseState.error(message: failure.message, error: failure)),
      (data) {
        if (data.isEmpty) {
          emit(BaseState.empty('No data available'));
          return;
        }
        // Persist the fetched data
        secureStorage.write(
          key: _kaloriDataKey,
          value: jsonEncode(data.first.toJson()),
        );
        emit(BaseState.success(data: data.first));
      },
    );
  }

  Future<void> _addNutrition(
    KaloriAddNutrition event,
    Emitter<BaseState<KaloriEntity>> emit,
  ) async {
    emit(BaseState.loading());
    final result = await addNutritionUseCase.call(
      AddParams(data: event.kalori),
    );
    result.fold((failure) => emit(BaseState.error(message: failure.message)), (
      data,
    ) {
      // Persist the added data
      secureStorage.write(
        key: _kaloriDataKey,
        value: jsonEncode(data.first.toJson()),
      );
      emit(BaseState.success(data: data.first));
    });
  }

  double calculateBMI(double height, double weight) {
    if (height <= 0 || weight <= 0) return 0;
    final heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String getBMIStatus(double height, double weight) {
    final bmi = calculateBMI(height, weight);
    if (bmi < 18.5) {
      return '${bmi.toStringAsFixed(2)} (Kurus)';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return '${bmi.toStringAsFixed(2)} (Normal)';
    } else {
      return '${bmi.toStringAsFixed(2)} (Obesitas)';
    }
  }

  Future<String> calculateKalori(
    String gender,
    double height,
    double weight,
    int age,
    double factorActivity,
  ) async {
    final typeDiabetesString =
        await sl<FlutterSecureStorage>().read(key: typeDiabetesKey) ??
        typeNormal.toString();
    final typeDiabetes = int.parse(typeDiabetesString);
    double bmr;
    if (gender == 'laki-laki') {
      if (typeDiabetes == typeNormal) {
        bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
      } else {
        bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
      }
    } else {
      if (typeDiabetes == typeNormal) {
        bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      } else {
        bmr = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
      }
    }
    int kalori = (bmr * factorActivity).toInt();
    if (typeDiabetes == typeDM) {
      final percentage = factorActivity > 1.37 ? 0.2 : 0.1;
      kalori = kalori - (kalori * percentage).toInt();
    }
    return kalori.toString();
  }

  List<String> getTujuanDietArg(int typeDiabetes, String bmiStatus) {
    final match = RegExp(r'\(([^)]+)\)').firstMatch(bmiStatus);
    if (match != null) {
      bmiStatus = match.group(1)!; // the content inside parentheses
    }
    if (typeDiabetes == typeDM) {
      if (bmiStatus == normalWeight) {
        return tujuanDiet['Normal']![bmiStatus]!;
      }
      return tujuanDiet['DM']![bmiStatus]!;
    }
    return tujuanDiet['Normal']![bmiStatus]!;
  }
}
