import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../widget/base_page.dart';
import '../../../widget/custom_button.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<String> answers = [];
  List<bool> isAnswered = [];

  bool get allAnswered => isAnswered.every((e) => e);
  bool get hasAtLeastTwoYes =>
      answers.where((answer) => answer == 'Ya').length >= 2;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isAnswered = List<bool>.filled(questions.length, false);
    answers = List<String>.filled(questions.length, '');
  }

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }

  void _updateAnswer(int index, String value) {
    setState(() {
      answers[index] = value;
      isAnswered[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: const Text('Kuesioner Kesehatan')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        questions[index],
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.verticalSpace,
                      RadioGroup(
                        groupValue: answers[index],
                        onChanged: (value) => _updateAnswer(index, value!),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Radio(value: 'Ya'),
                            Text('Ya', style: TextStyle(fontSize: 16.sp)),
                            Radio(value: 'Tidak'),
                            Text('Tidak', style: TextStyle(fontSize: 16.sp)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          16.verticalSpace,
          if (allAnswered)
            CustomButton(
              textButton: "Lanjutkan",
              onTap: () {
                setState(() {
                  isLoading = true;
                });
                // Aksi ketika next ditekan
                if (hasAtLeastTwoYes) {
                  sl<AppNavigator>().pushNamed(gulaDarahPage);
                } else {
                  sl<AppNavigator>().pushNamed(
                    recommendationPage,
                    arguments: recommendations['normal'],
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
