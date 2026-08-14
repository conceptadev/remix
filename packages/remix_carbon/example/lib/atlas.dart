import 'package:flutter/material.dart';
import 'package:mix_atlas/mix_atlas.dart';

import 'component_catalog.dart';

void main() => runApp(const CarbonAtlasApp());

class CarbonAtlasApp extends StatelessWidget {
  const CarbonAtlasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carbon component atlas',
      debugShowCheckedModeBanner: false,
      home: AtlasCatalogViewer(catalog: carbonAtlasCatalog),
    );
  }
}
