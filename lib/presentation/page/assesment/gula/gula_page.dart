import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/base_state.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/gula_darah/gula_darah_entity.dart';
import '../../../../gen/colors.gen.dart';
import '../../../bloc/assesment/gula_cubit.dart';
import '../../../widget/base_page.dart';
import '../../../widget/custom_button.dart';
import '../widget/custom_date_scroll.dart';
import '../widget/custom_empty_data.dart';

class GulaPage extends StatefulWidget {
  const GulaPage({super.key});

  @override
  State<GulaPage> createState() => _GulaPageState();
}

class _GulaPageState extends State<GulaPage> {
  final GulaCubit _gulaCubit = sl<GulaCubit>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: Text('Kadar Gula Darah')),
      body: ListView(
        children: [
          CustomDateScroll(
            onChanged: (DateTime value) async {
              await _gulaCubit.getListGula(
                DateFormat('yyyy-MM-dd').format(value),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<GulaCubit, BaseState<List<GulaDarahEntity>>>(
            builder: (context, state) {
              if (state.isEmpty) {
                return const CustomEmptyData(
                  text: 'Gula Darah',
                  routePage: addGulaPage,
                );
              }
              if (state.isSuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Waktu Pemeriksaan',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Hasil Pemeriksaan',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    ...state.data!.asMap().entries.map((e) {
                      String gulaType = 'Sebelum Makan';
                      if (e.value.type == 1) {
                        gulaType = 'Sesudah Makan';
                      } else if (e.value.type == 2) {
                        gulaType = 'Puasa';
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: e.key % 2 == 0
                              ? ColorName.lightGrey
                              : Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Pukul ${e.value.time}'),
                                    Text(gulaType),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('${e.value.total} mg/dL')],
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
                        Navigator.pushNamed(context, addGulaPage);
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
