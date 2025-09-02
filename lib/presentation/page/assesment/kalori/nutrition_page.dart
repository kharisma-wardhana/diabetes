import 'package:diabetes/presentation/bloc/kalori/kalori_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../bloc/kalori/kalori_bloc.dart';
import '../../../widget/base_page.dart';
import '../../../widget/custom_button.dart';
import '../widget/custom_date_picker.dart';

class NutrisiPage extends StatefulWidget {
  const NutrisiPage({super.key});

  @override
  State<NutrisiPage> createState() => _NutrisiPageState();
}

class _NutrisiPageState extends State<NutrisiPage> {
  static final TextEditingController makananController = TextEditingController(
    text: 'Nasi Putih, 306 Kal',
  );
  static final TextEditingController dateController = TextEditingController(
    text: '',
  );
  static final TextEditingController typeController = TextEditingController(
    text: '',
  );
  static final KaloriBloc nutritionCubit = sl<KaloriBloc>();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Widget _buildChipType({required String type, required IconData icon}) {
    return InkWell(
      child: SizedBox(
        width: 100,
        child: Chip(
          label: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  icon,
                  color: typeController.text == type
                      ? ColorName.white
                      : ColorName.primary,
                ),
                Text(
                  type,
                  style: TextStyle(
                    color: typeController.text == type
                        ? ColorName.white
                        : ColorName.primary,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: typeController.text == type
              ? ColorName.primary
              : ColorName.white,
        ),
      ),
      onTap: () {
        setState(() => typeController.text = type);
      },
    );
  }

  Widget _buildDropdownListMakan({required List<Map<String, String>> items}) {
    return Column(
      children: [
        DropdownButtonFormField(
          isExpanded: true,
          isDense: false,
          initialValue: makananController.text,
          items: items.map((e) {
            return DropdownMenuItem(
              value: '${e['nama']}, ${e['kalori']}',
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset(e['image']!, fit: BoxFit.contain),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${e['nama']}'),
                        const SizedBox(height: 8),
                        Text('${e['kalori']}'),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              makananController.text = value!;
            });
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(title: Text('Tambahkan Makanan')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDatePicker(controller: dateController),
            SizedBox(height: 8.h),
            _buildDropdownListMakan(
              items: [
                {
                  'image': Assets.images.telurDadar.path,
                  'nama': 'Telur Dadar',
                  'kalori': '77 Kal',
                },
                {
                  'image': Assets.images.jeruk.path,
                  'nama': 'Jeruk',
                  'kalori': '62 Kal',
                },
                {
                  'image': Assets.images.nasiPutih.path,
                  'nama': 'Nasi Putih',
                  'kalori': '306 Kal',
                },
                {
                  'image': Assets.images.ayamGoreng.path,
                  'nama': 'Ayam Goreng',
                  'kalori': '260 Kal',
                },
                {
                  'image': Assets.images.capcay.path,
                  'nama': 'Capcay Kuah',
                  'kalori': '120 Kal',
                },
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildChipType(type: 'Pagi', icon: Icons.cloud),
                _buildChipType(type: 'Siang', icon: Icons.sunny),
                _buildChipType(type: 'Malam', icon: Icons.dark_mode_outlined),
              ],
            ),
            SizedBox(height: 8.h),
            const Spacer(),
            CustomButton(
              textButton: 'Tambahkan',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  setState(() => isLoading = true);
                  List<String> parts = makananController.text.split(', ');
                  String total = parts[1].split(' ')[0];
                  nutritionCubit.add(
                    KaloriAddNutrition(
                      KaloriEntity(
                        date: dateController.text,
                        type: typeController.text,
                        name: parts[0],
                        total: total,
                      ),
                    ),
                  );
                  setState(() => isLoading = false);
                  sl<AppNavigator>().pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
