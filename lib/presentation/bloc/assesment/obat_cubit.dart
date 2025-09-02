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

  Future<void> updateStatusMedicine(int medicineId, int status) async {
    emit(BaseState.loading());
    final result = await updateStatusMedicineUseCase.call(
      UpdateParams(dataId: medicineId, data: status),
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
}
