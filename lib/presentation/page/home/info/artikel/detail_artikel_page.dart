import 'package:flutter/material.dart';

import '../../../../../domain/entity/article/article_entity.dart';

class DetailArtikelPage extends StatelessWidget {
  final ArticleEntity article;
  const DetailArtikelPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('INFORMASI DIABETES')),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(30),
          minScale: 0.5,
          maxScale: 4.0,
          panEnabled: false,
          child: Image.network(article.image!, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
