import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../widget/base_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: const Text('TENTANG APLIKASI')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.profilAplikasi.path),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
