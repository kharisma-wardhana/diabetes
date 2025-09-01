import 'package:diabetes/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../widget/base_page.dart';
import '../../../widget/custom_button.dart';

class RecommendationPage extends StatelessWidget {
  final List<String> data;
  const RecommendationPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: const Text('Rekomendasi')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(
                  Icons.recommend_rounded,
                  size: 64,
                  color: ColorName.primary,
                ),
                title: Text(data[index]),
                contentPadding: EdgeInsets.only(bottom: 8.h),
              ),
            ),
          ),
          CustomButton(
            textButton: "Lanjutkan",
            onTap: () {
              sl<AppNavigator>().pushNamed(activityPage);
            },
          ),
        ],
      ),
    );
  }
}
