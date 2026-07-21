import 'dart:async';

import 'package:mix_atlas/golden.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Atlas goldens are captured on one macOS version but verified on CI's
  // (pinned macOS 15). CoreText rasterizes antialiased edges a few pixels
  // differently across macOS versions — notably the spinner arc and the
  // text_field glyphs/selection — drifting up to ~0.02% of pixels while the
  // component itself is unchanged. Hold the tolerance at 0.05%: ~2.5x above
  // that measured host noise (a physically bounded count of edge pixels), yet
  // far below any real regression, which moves orders of magnitude more pixels.
  // Structured capture hashes remain exact regardless.
  AtlasGoldens.precisionTolerance = 0.0005;
  configureAtlasGoldenComparator();
  await loadAtlasFonts();
  await testMain();
}
