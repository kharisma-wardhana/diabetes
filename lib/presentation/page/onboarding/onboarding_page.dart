import 'package:flutter/material.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/injector/service_locator.dart';
import '../../../gen/assets.gen.dart';
import 'onboarding_card.dart';
import 'onboarding_diabetes_card.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  late final List<Widget> _onboardingCards;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onboardingCards = [
      OnboardingCard(
        image: Assets.images.logo.path,
        title: 'Selamat Datang',
        subtitle: '',
        onTap: () {
          _pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
          );
        },
      ),
      OnboardDiabetesCard(
        title: 'Apakah Anda Seorang?',
        optionA: 'Diabetisi',
        optionB: 'Non Diabetisi',
        infoA:
            'adalah orang yang telah didiagnosa medis mengalami penyakit Diabetes Melitus yang ditandai dengan kadar gula darah yang tidak terkontrol dengan baik (cenderung tinggi).',
        infoB:
            'adalah orang yang tidak sedang mengidap penyakit Diabetes Melitus.',
        image: Assets.images.logoElan.path,
        onTapA: () {
          _pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
          );
        },
        onTapB: () {
          sl<AppNavigator>().pushReplacementNamed(antropometriPage);
        },
      ),
      OnboardDiabetesCard(
        title: 'Anda Diabetes Tipe Apa?',
        optionA: 'Diabetes Tipe 1',
        optionB: 'Diabetes Tipe 2',
        infoA:
            'adalah keadaan dimana tubuh tidak mampu memproduksi insulin karena ada kerusakan sel pankreas hingga mengakibatkan kadar gula dalam darah terlalu tinggi.',
        infoB:
            'adalah keadaan dimana pankreas tidak mampu menghasilkan insulin dengan jumlah yang memadai atau tubuh tidak mampu menggunakan insulin yang tersedia dengan benar sehingga mengakibatkan kadar gula dalam darah terlalu tinggi .',
        image: Assets.images.logoElan.path,
        onTapA: () {
          sl<AppNavigator>().pushReplacementNamed(antropometriPage);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: _onboardingCards,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
