import 'dart:async';
import 'dart:io';

import 'package:mix_atlas/golden.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  if (!Platform.environment.containsKey('CI')) {
    AtlasGoldens.precisionTolerance = 0.0001;
  }
  configureAtlasGoldenComparator();
  await loadAtlasFonts();
  await testMain();
}
