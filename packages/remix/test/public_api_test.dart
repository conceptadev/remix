import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('mode-aware Fortal filters are constructible from the public API', () {
    final modifier = fortalModeAwareFilter(
      light: const [RemixCssColorFilterOperation.brightness(1.1)],
      dark: const [RemixCssColorFilterOperation.contrast(0.9)],
    );

    expect(modifier, isNotNull);
  });
}
