import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatelessWidget {
  final TextEditingController controller;
  final List<String> items;
  final Function onChanged;
  const CustomDropdown({
    super.key,
    required this.controller,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      isExpanded: true,
      value: controller.text,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
        padding: const EdgeInsets.symmetric(vertical: 4),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 60, // Fixed height to accommodate 2 lines of text
        padding: EdgeInsets.zero,
      ),
      buttonStyleData: const ButtonStyleData(
        height: 50, // Increased height to accommodate 2 lines of text
        padding: EdgeInsets.symmetric(horizontal: 12),
      ),
      selectedItemBuilder: (context) {
        return items.map((item) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Text(
              item,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList();
      },
      items: items.asMap().entries.map((e) {
        return DropdownMenuItem(
          value: e.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 10.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    e.value,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
