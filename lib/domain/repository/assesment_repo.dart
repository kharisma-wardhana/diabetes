import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../core/usecase.dart';
import '../entity/assesment/activity/activity_entity.dart';
import '../entity/assesment/antropometri/antropometri_entity.dart';
import '../entity/assesment/asam_urat_entity.dart';
import '../entity/assesment/assesment_entity.dart';
import '../entity/assesment/ginjal_entity.dart';
import '../entity/assesment/gula_darah/gula_darah_entity.dart';
import '../entity/assesment/hb1ac_entity.dart';
import '../entity/assesment/kalori/kalori_entity.dart';
import '../entity/assesment/kolesterol_entity.dart';
import '../entity/assesment/obat_entity.dart';
import '../entity/assesment/tensi_entity.dart';
import '../entity/assesment/water_entity.dart';

abstract class AssesmentRepository {
  Future<Either<Failure, AntropometriEntity>> addAntropometri(
    AddParams<AntropometriEntity> params,
  );

  Future<Either<Failure, AntropometriEntity?>> getDetailAntropometri();

  Future<Either<Failure, AssesmentEntity>> getAssesment();
  Future<Either<Failure, List<WaterEntity>>> getGraphicWater(
    SearchParams params,
  );
  Future<Either<Failure, List<WaterEntity>>> getListWater(SearchParams params);
  Future<Either<Failure, List<WaterEntity>>> addWater(
    AddParams<WaterEntity> params,
  );

  Future<Either<Failure, List<ActivityEntity>>> getListActivity(
    SearchParams params,
  );

  Future<Either<Failure, List<ActivityEntity>>> addActivity(
    AddParams<ActivityEntity> params,
  );

  Future<Either<Failure, List<GulaDarahEntity>>> getGraphicGula(
    SearchParams params,
  );
  Future<Either<Failure, List<GulaDarahEntity>>> getListGulaDarah(
    SearchParams params,
  );

  Future<Either<Failure, List<GulaDarahEntity>>> addGulaDarah(
    AddParams<GulaDarahEntity> params,
  );

  Future<Either<Failure, List<TensiEntity>>> getGraphicTekananDarah(
    SearchParams params,
  );
  Future<Either<Failure, List<TensiEntity>>> getListTekananDarah(
    SearchParams params,
  );

  Future<Either<Failure, List<TensiEntity>>> addTekananDarah(
    AddParams<TensiEntity> params,
  );

  Future<Either<Failure, List<KolesterolEntity>>> getGraphicKolesterol(
    SearchParams params,
  );
  Future<Either<Failure, List<KolesterolEntity>>> getListKolesterol(
    SearchParams params,
  );

  Future<Either<Failure, List<KolesterolEntity>>> addKolesterol(
    AddParams<KolesterolEntity> params,
  );

  Future<Either<Failure, List<AsamUratEntity>>> getGraphicAsamUrat(
    SearchParams params,
  );
  Future<Either<Failure, List<AsamUratEntity>>> getListAsamUrat(
    SearchParams params,
  );

  Future<Either<Failure, List<AsamUratEntity>>> addAsamUrat(
    AddParams<AsamUratEntity> params,
  );

  Future<Either<Failure, List<Hb1acEntity>>> getGraphicHb1ac(
    SearchParams params,
  );
  Future<Either<Failure, List<Hb1acEntity>>> getListHb1ac(SearchParams params);

  Future<Either<Failure, List<Hb1acEntity>>> addHb1ac(
    AddParams<Hb1acEntity> params,
  );

  Future<Either<Failure, List<GinjalEntity>>> getGraphicGinjal(
    SearchParams params,
  );
  Future<Either<Failure, List<GinjalEntity>>> getListGinjal(
    SearchParams params,
  );

  Future<Either<Failure, List<GinjalEntity>>> addGinjal(
    AddParams<GinjalEntity> params,
  );

  Future<Either<Failure, List<ObatEntity>>> getAllMedicine(SearchParams params);

  Future<Either<Failure, List<ObatEntity>>> addMedicine(
    AddParams<ObatEntity> params,
  );

  Future<Either<Failure, List<ObatEntity>>> updateStatusMedicine(
    UpdateParams<Map<String, int>> params,
  );

  Future<Either<Failure, List<KaloriEntity>>> getAllNutrition(
    SearchParams params,
  );

  Future<Either<Failure, List<KaloriEntity>>> addNutrition(
    AddParams<KaloriEntity> params,
  );
}
