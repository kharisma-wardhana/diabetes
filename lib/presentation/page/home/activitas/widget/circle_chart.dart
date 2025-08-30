import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'circle_chart_painter.dart';

class CircleChart extends StatelessWidget {
  final int currentValue;
  final double progressValue;
  final String title;
  final String unit;

  const CircleChart({
    super.key,
    required this.currentValue,
    required this.progressValue,
    required this.title,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(200.w, 200.h),
            painter: CircleChartPainter(progressValue),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                '$currentValue',
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
              Text(unit, style: TextStyle(fontSize: 16.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
