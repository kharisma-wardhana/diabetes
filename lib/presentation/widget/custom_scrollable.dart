import 'package:flutter/material.dart';

class CustomScrollable extends StatelessWidget {
  const CustomScrollable({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height:
            MediaQuery.of(context).size.height -
            kToolbarHeight - // height of AppBar
            MediaQuery.of(context).padding.top - // height of status bar
            MediaQuery.of(context).padding.bottom, // height of bottom bar
        child: child,
      ),
    );
  }
}
