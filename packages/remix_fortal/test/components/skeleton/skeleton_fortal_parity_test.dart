import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  testWidgets('recipe matches the pinned Skeleton surface and timing', (
    tester,
  ) async {
    final result = await _resolve(tester);
    final spec = result.spec;
    final box = spec.container.spec;
    final decoration = box.decoration! as BoxDecoration;

    expect(decoration.color, result.grayA3);
    expect(spec.pulseColor, result.grayA4);
    expect(spec.duration, const Duration(milliseconds: 1000));
    expect(box.constraints?.minHeight, 12);
    expect(
      (decoration.borderRadius! as BorderRadius).topLeft,
      const Radius.circular(3),
    );
  });

  testWidgets('space and radius metrics scale with Fortal', (tester) async {
    final result = await _resolve(tester, scaling: .percent110);
    final box = result.spec.container.spec;
    final decoration = box.decoration! as BoxDecoration;

    expect(box.constraints?.minHeight, closeTo(13.2, 1e-9));
    expect(
      (decoration.borderRadius! as BorderRadius).topLeft.x,
      closeTo(3.3, 1e-9),
    );
    expect(result.spec.duration, const Duration(milliseconds: 1000));
  });
}

Future<({SkeletonSpec spec, Color grayA3, Color grayA4})> _resolve(
  WidgetTester tester, {
  FortalScaling scaling = FortalScaling.percent100,
}) async {
  late ({SkeletonSpec spec, Color grayA3, Color grayA4}) result;
  await tester.pumpWidget(
    FortalScope(
      scaling: scaling,
      child: Builder(
        builder: (context) {
          result = (
            spec: fortalSkeletonStyle().build(context).spec,
            grayA3: MixScope.tokenOf(FortalTokens.grayA3, context),
            grayA4: MixScope.tokenOf(FortalTokens.grayA4, context),
          );
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return result;
}
