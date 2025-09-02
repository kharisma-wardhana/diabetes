import 'package:flutter/material.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../gen/colors.gen.dart';
import '../../../bloc/assesment/obat_cubit.dart';
import '../../../widget/base_page.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_dropdown.dart';
import '../../../widget/custom_text_field.dart';
import '../widget/custom_date_picker.dart';

class AddObatPage extends StatefulWidget {
  const AddObatPage({super.key});

  @override
  State<AddObatPage> createState() => _AddObatPageState();
}

class _AddObatPageState extends State<AddObatPage> {
  static final AppNavigator _navigationHelper = sl<AppNavigator>();
  static final ObatCubit _medicineCubit = sl<ObatCubit>();

  bool isLoading = false;
  static final TextEditingController dateController = TextEditingController();
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController typeController = TextEditingController();
  static final TextEditingController durasiController = TextEditingController();
  static final TextEditingController dosisHariController =
      TextEditingController();
  static final TextEditingController dosisTypeController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget _buildChipType({required String type}) {
    int typeInt = 0;
    if (type == 'Saat Makan') {
      typeInt = 1;
    } else if (type == 'Sesudah Makan') {
      typeInt = 2;
    }
    return InkWell(
      child: Chip(
        elevation: 1,
        label: SizedBox(
          width: double.infinity,
          child: Text(
            type,
            style: TextStyle(
              color: typeController.text == typeInt.toString()
                  ? ColorName.white
                  : ColorName.primary,
            ),
          ),
        ),
        backgroundColor: typeController.text == typeInt.toString()
            ? ColorName.primary
            : ColorName.white,
      ),
      onTap: () {
        setState(() {
          typeController.text = typeInt.toString();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(title: Text('Tambahkan Obat')),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            CustomDatePicker(controller: dateController),
            CustomTextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              labelText: 'Nama Obat',
            ),
            CustomTextField(
              controller: durasiController,
              labelText: 'Durasi Minum Obat',
              suffixIcon: const Text('Hari'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: dosisHariController,
                    keyboardType: TextInputType.number,
                    labelText: 'Dosis',
                    suffixIcon: const Text('x/hari'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomDropdown(
                    controller: dosisTypeController,
                    items: obatType,
                    onChanged: (val) {
                      setState(() => dosisTypeController.text = val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildChipType(type: 'Sebelum Makan'),
            const SizedBox(height: 8),
            _buildChipType(type: 'Saat Makan'),
            const SizedBox(height: 8),
            _buildChipType(type: 'Sesudah Makan'),
            const SizedBox(height: 36),
            CustomButton(
              textButton: 'Tambahkan',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => isLoading = true);
                  await _medicineCubit.addMedicine(
                    dateController.text,
                    nameController.text,
                    int.parse(durasiController.text),
                    '${dosisHariController.text}  ${dosisTypeController.text}',
                    int.parse(typeController.text),
                  );
                  setState(() => isLoading = false);
                  _navigationHelper.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
