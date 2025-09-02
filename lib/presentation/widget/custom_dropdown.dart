import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
    return Column(
      children: [
        DropdownButtonFormField2(
          isExpanded: true,
          isDense: false,
          value: controller.text,
          barrierColor: Colors.black.withValues(alpha: 0.7),
          items: items.asMap().entries.map((e) {
            return DropdownMenuItem(
              value: e.value,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
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
        ),
      ],
    );
  }
}
