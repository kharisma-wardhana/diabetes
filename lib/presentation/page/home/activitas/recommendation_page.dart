import 'package:diabetes/presentation/widget/base_page.dart';
import 'package:flutter/material.dart';

class RecommendationPage extends StatelessWidget {
  final List<String> data;
  const RecommendationPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(data[index]));
        },
      ),
    );
  }
}
