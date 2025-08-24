import 'package:flutter/material.dart';

class DetailEdukasiPage extends StatelessWidget {
  final Map<String, dynamic> edukasi;

  const DetailEdukasiPage({super.key, required this.edukasi});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(edukasi['title'])),
        body: ListView(
          children: (edukasi['image'] as List<String>)
              .map(
                (e) => InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(20.0),
                  minScale: 0.5,
                  maxScale: 4.0,
                  panEnabled: false,
                  child: Image.asset(e, fit: BoxFit.fitWidth),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
