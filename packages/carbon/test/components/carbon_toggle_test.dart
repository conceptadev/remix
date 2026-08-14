import 'package:carbon/carbon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/pump.dart';

void main() {
  testWidgets(
    'CarbonToggle forwards switch behavior and visible state labels',
    (tester) async {
      final semantics = tester.ensureSemantics();
      var value = false;
      await tester.pumpCarbonApp(
        CarbonToggle(
          selected: value,
          label: 'Notifications',
          onChanged: (next) => value = next,
        ),
      );

      expect(find.text('Off'), findsOneWidget);
      expect(
        tester.getSemantics(find.byType(RemixSwitch)),
        isSemantics(
          label: 'Notifications',
          hasToggledState: true,
          isToggled: false,
          isEnabled: true,
          hasTapAction: true,
        ),
      );
      await tester.tap(find.text('Off'));
      expect(value, isTrue);
      semantics.dispose();
    },
  );

  testWidgets('Carbon toggle recipe matches regular and small geometry', (
    tester,
  ) async {
    late ({SwitchSpec regular, SwitchSpec small}) result;
    await tester.pumpWidget(
      CarbonScope(
        child: Builder(
          builder: (context) {
            result = (
              regular: carbonToggleStyle().build(context).spec,
              small: carbonToggleStyle(
                size: CarbonToggleSize.small,
              ).build(context).spec,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(result.regular.container.spec.constraints?.minWidth, 48);
    expect(result.regular.container.spec.constraints?.minHeight, 24);
    expect(result.regular.thumb.spec.constraints?.minWidth, 18);
    expect(result.small.container.spec.constraints?.minWidth, 32);
    expect(result.small.container.spec.constraints?.minHeight, 16);
    expect(result.small.thumb.spec.constraints?.minWidth, 10);
  });
}
