import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/obat_entity.dart';
import '../../../domain/usecase/medicine/add_medicine_usecase.dart';
import '../../../domain/usecase/medicine/get_list_medicine_usecase.dart';
import '../../../domain/usecase/medicine/update_status_medicine_usecase.dart';

class ObatCubit extends Cubit<BaseState<List<ObatEntity>>> {
  final GetListMedicineUseCase getListMedicineUseCase;
  final AddMedicineUseCase addMedicineUseCase;
  final UpdateStatusMedicineUseCase updateStatusMedicineUseCase;

  ObatCubit({
    required this.getListMedicineUseCase,
    required this.addMedicineUseCase,
    required this.updateStatusMedicineUseCase,
  }) : super(BaseState.initial());

  Future<void> getAllMedicine(String date) async {
    emit(BaseState.loading());
    final result = await getListMedicineUseCase.call(SearchParams(date: date));

    return result.fold(
      (failure) =>
          emit(BaseState.error(message: failure.message, error: failure)),
      (data) {
        if (data.isEmpty) {
          emit(BaseState.empty('No data available'));
          return;
        }
        emit(BaseState.success(data: data));
      },
    );
  }

  Future<void> addMedicine(
    String date,
    String name,
    int duration,
    String dosis,
    int type,
  ) async {
    emit(BaseState.loading());
    final result = await addMedicineUseCase.call(
      AddParams(
        data: ObatEntity(
          date: date,
          type: type,
          duration: duration,
          dosis: dosis,
          name: name,
        ),
      ),
    );
    return result.fold(
      (failure) =>
          emit(BaseState.error(message: failure.message, error: failure)),
      (data) {
        if (data.isEmpty) {
          emit(BaseState.empty('No data available'));
          return;
        }
        emit(BaseState.success(data: data));
      },
    );
  }

  Future<void> updateStatusMedicine(
    int medicineId,
    int status,
    int count,
  ) async {
    emit(BaseState.loading());
    final result = await updateStatusMedicineUseCase.call(
      UpdateParams(
        dataId: medicineId,
        data: {'status': status, 'count': count},
      ),
    );
    return result.fold(
      (failure) =>
          emit(BaseState.error(message: failure.message, error: failure)),
      (data) {
        if (data.isEmpty) {
          emit(BaseState.empty('No data available'));
          return;
        }
        emit(BaseState.success(data: data));
      },
    );
  }

  /// Update dosage count for a medicine
  /// This method ensures the count doesn't exceed the total required dosage
  Future<void> updateDosageCount(
    int medicineId,
    int newCount,
    int maxDosage,
  ) async {
    // Clamp the new count to valid range
    final clampedCount = newCount.clamp(0, maxDosage);
    final status = clampedCount < maxDosage
        ? 0
        : 1; // 0: not completed, 1: completed
    await updateStatusMedicine(medicineId, status, clampedCount);
  }

  /// Increment dosage count for a medicine
  Future<void> incrementDosage(ObatEntity medicine) async {
    final dosisText = medicine.dosis;
    final dosisMatch = RegExp(r'(\d+)').firstMatch(dosisText);
    final maxDosage = dosisMatch != null ? int.parse(dosisMatch.group(1)!) : 1;
    final currentCount = medicine.count ?? 0;

    if (currentCount < maxDosage) {
      await updateDosageCount(medicine.id!, currentCount + 1, maxDosage);
    }
  }

  /// Decrement dosage count for a medicine
  Future<void> decrementDosage(ObatEntity medicine) async {
    final currentCount = medicine.count ?? 0;

    if (currentCount > 0) {
      final dosisText = medicine.dosis;
      final dosisMatch = RegExp(r'(\d+)').firstMatch(dosisText);
      final maxDosage = dosisMatch != null
          ? int.parse(dosisMatch.group(1)!)
          : 1;
      await updateDosageCount(medicine.id!, currentCount - 1, maxDosage);
    }
  }
}
