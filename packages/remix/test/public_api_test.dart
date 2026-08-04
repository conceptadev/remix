import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('the skeleton family is constructible from the public API', () {
    const spec = SkeletonSpec(
      container: StyleSpec(spec: BoxSpec()),
      pulseColor: Color(0xFFCCCCCC),
      duration: Duration(milliseconds: 1000),
    );
    final style = SkeletonStyler()
        .size(120, 24)
        .color(const Color(0xFFEEEEEE))
        .borderRounded(4)
        .pulseColor(const Color(0xFFCCCCCC))
        .duration(const Duration(milliseconds: 1000));

    expect(
      RemixSkeleton(style: style, child: const Text('Jane')),
      isA<RemixSkeleton>(),
    );
    expect(RemixSkeleton(styleSpec: spec), isA<RemixSkeleton>());
    expect(
      style(child: const Text('Jane'), loading: false),
      isA<RemixSkeleton>(),
    );
    expect(
      RemixSkeleton.styleFrom(pulseColor: const Color(0xFFCCCCCC)),
      isA<SkeletonStyler>(),
    );
  });

  test('mode-aware Fortal filters are constructible from the public API', () {
    final modifier = fortalModeAwareFilter(
      light: const [RemixCssColorFilterOperation.brightness(1.1)],
      dark: const [RemixCssColorFilterOperation.contrast(0.9)],
    );

    expect(modifier, isNotNull);
  });
}
