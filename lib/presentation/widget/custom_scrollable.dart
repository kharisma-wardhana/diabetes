import 'package:flutter/material.dart';

class CustomScrollable extends StatelessWidget {
  const CustomScrollable({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: child,
      ),
    );
  }
}
