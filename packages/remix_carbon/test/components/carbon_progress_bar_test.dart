import 'dart:ui' show SemanticsRole;

import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets('CarbonProgressBar resolves size and status tokens', (
    tester,
  ) async {
    late ({
      ProgressSpec big,
      ProgressSpec small,
      ProgressSpec error,
      Color interactive,
      Color supportError,
    })
    result;
    await tester.pumpWidget(
      CarbonScope(
        child: Builder(
          builder: (context) {
            result = (
              big: carbonProgressBarStyle().build(context).spec,
              small: carbonProgressBarStyle(
                size: CarbonProgressBarSize.small,
              ).build(context).spec,
              error: carbonProgressBarStyle(
                status: CarbonProgressBarStatus.error,
              ).build(context).spec,
              interactive: CarbonTokens.interactive.resolve(context),
              supportError: CarbonTokens.supportError.resolve(context),
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(result.big.container.spec.constraints?.minHeight, 8);
    expect(result.small.container.spec.constraints?.minHeight, 4);
    expect(_background(result.big.indicator.spec), result.interactive);
    expect(_background(result.error.indicator.spec), result.supportError);
  });

  testWidgets('renders label/helper and exact progress semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpCarbonApp(
      const CarbonProgressBar(
        value: 0.42,
        label: 'Uploading',
        helperText: '42 of 100 files',
      ),
    );

    expect(find.text('Uploading'), findsOneWidget);
    expect(find.text('42 of 100 files'), findsOneWidget);
    final node = tester.getSemantics(find.byType(RemixProgress));
    expect(node, isSemantics(label: 'Uploading', value: '42'));
    expect(node.role, SemanticsRole.progressBar);
    semantics.dispose();
  });
}

Color? _background(BoxSpec spec) => (spec.decoration as BoxDecoration?)?.color;
