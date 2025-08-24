import 'package:flutter/material.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/injector/service_locator.dart';
import '../../../../widget/base_page.dart';

class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: const Text('EDUKASI BENCANA')),
      body: ListView.separated(
        separatorBuilder: (context, index) =>
            const Divider(height: 1, thickness: 1, color: Colors.grey),
        itemCount: edukasi.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(edukasi[index]['title']),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
          onTap: () {
            sl<AppNavigator>().pushNamed(
              edukasiDetailPage,
              arguments: edukasi[index],
            );
          },
        ),
      ),
    );
  }
}
