import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../widget/custom_button.dart';

class OnboardDiabetesCard extends StatelessWidget {
  final String title;
  final String optionA;
  final String optionB;
  final String image;
  final String infoA;
  final String infoB;
  final VoidCallback onTapA;
  final VoidCallback? onTapB;

  const OnboardDiabetesCard({
    super.key,
    required this.title,
    required this.optionA,
    required this.optionB,
    required this.image,
    required this.onTapA,
    this.onTapB,
    required this.infoA,
    required this.infoB,
  });

  void _showModalBottomSheet(BuildContext context, String info, String data) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.8,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: <Widget>[
              Text(
                info.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.sp),
              ),
              Text(data, style: TextStyle(fontSize: 30.sp)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(Assets.images.border.path, fit: BoxFit.fill),
        ),
        SizedBox(height: 64.h),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(image, fit: BoxFit.contain),
        ),
        const Spacer(),
        Text(
          title,
          style: TextStyle(color: ColorName.primary, fontSize: 35.sp),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomButton(textButton: optionA, onTap: onTapA),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                _showModalBottomSheet(context, optionA, infoA);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorName.lightGrey,
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Icon(
                  Icons.question_mark_rounded,
                  size: 50.h,
                  color: ColorName.darkGrey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomButton(textButton: optionB, onTap: onTapB ?? onTapA),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                _showModalBottomSheet(context, optionB, infoB);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorName.lightGrey,
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Icon(
                  Icons.question_mark_rounded,
                  size: 50.h,
                  color: ColorName.darkGrey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 64.h),
      ],
    );
  }
}
