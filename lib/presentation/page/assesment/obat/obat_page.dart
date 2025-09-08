import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/base_state.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/obat_entity.dart';
import '../../../../gen/colors.gen.dart';
import '../../../bloc/assesment/obat_cubit.dart';
import '../../../widget/base_page.dart';
import '../../../widget/custom_button.dart';
import '../widget/custom_date_scroll.dart';
import '../widget/custom_empty_data.dart';

class ObatPage extends StatefulWidget {
  const ObatPage({super.key});

  @override
  State<ObatPage> createState() => _ObatPageState();
}

class _ObatPageState extends State<ObatPage> {
  static final ObatCubit _medicineCubit = sl<ObatCubit>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: Text('Pengingat Obat')),
      body: ListView(
        children: [
          CustomDateScroll(
            onChanged: (DateTime value) async {
              await _medicineCubit.getAllMedicine(
                DateFormat('yyyy-MM-dd').format(value),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<ObatCubit, BaseState<List<ObatEntity>>>(
            builder: (context, state) {
              if (state.isEmpty) {
                return const CustomEmptyData(
                  text: 'Obat',
                  routePage: addObatPage,
                );
              }
              if (state.isSuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...state.data!.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: ColorName.lightGrey,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text(e.name), Text(e.dosis)],
                                ),
                                e.status != null
                                    ? Text(
                                        e.status == 1 ? 'SUDAH' : 'TERLAWATKAN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: e.status == 1
                                              ? ColorName.primary
                                              : Colors.red,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () async {
                                              await _medicineCubit
                                                  .updateStatusMedicine(
                                                    e.id!,
                                                    0,
                                                    (e.count ?? 0) - 1 < 0
                                                        ? 0
                                                        : (e.count ?? 0) - 1,
                                                  );
                                            },
                                            icon: const Icon(
                                              Icons.close_rounded,
                                              color: Colors.red,
                                            ),
                                            label: const Text(
                                              'Terlewat',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          TextButton.icon(
                                            onPressed: () async {
                                              await _medicineCubit
                                                  .updateStatusMedicine(
                                                    e.id!,
                                                    1,
                                                    e.count ?? 0 + 1,
                                                  );
                                            },
                                            icon: const Icon(
                                              Icons
                                                  .check_circle_outline_rounded,
                                              color: ColorName.primary,
                                            ),
                                            label: const Text(
                                              'Sudah',
                                              style: TextStyle(
                                                color: ColorName.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 18),
                    CustomButton(
                      textButton: 'Tambahkan',
                      onTap: () {
                        sl<AppNavigator>().pushNamed(addObatPage);
                      },
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: ColorName.primary),
              );
            },
          ),
        ],
      ),
    );
  }
}
