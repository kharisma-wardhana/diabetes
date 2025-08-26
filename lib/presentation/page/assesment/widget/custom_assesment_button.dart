import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../gen/colors.gen.dart';

class CustomAssesmentButton extends StatelessWidget {
  final String title;
  final List<String> data;
  final Function onTap;

  const CustomAssesmentButton({
    super.key,
    required this.title,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        8.verticalSpace,
        InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: () => onTap(),
          child: Container(
            padding: EdgeInsets.all(16.r),
            width: double.infinity, // Better than MediaQuery
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorName.primary, width: 2.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.asMap().entries.map((entry) {
                int index = entry.key;
                String text = entry.value;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                    ),
                    // Add spacing between items except for the last one
                    if (index < data.length - 1) 4.verticalSpace,
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
