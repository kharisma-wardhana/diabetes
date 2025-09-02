import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // The GlobalAuthListener will handle navigation based on AuthBloc state
    // This page just shows the splash screen
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300.w, // Responsive width
              child: Image.asset(
                Assets.images.elanIcon.path,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
