import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('Fortal control matrices', () {
    test('enum domains and defaults match Radix Themes 3.3.0', () {
      expect(FortalIconButtonSize.values, [
        FortalIconButtonSize.size1,
        FortalIconButtonSize.size2,
        FortalIconButtonSize.size3,
        FortalIconButtonSize.size4,
      ]);
      expect(FortalIconButtonVariant.values, [
        FortalIconButtonVariant.classic,
        FortalIconButtonVariant.solid,
        FortalIconButtonVariant.soft,
        FortalIconButtonVariant.surface,
        FortalIconButtonVariant.outline,
        FortalIconButtonVariant.ghost,
      ]);
      expect(FortalCheckboxSize.values, [
        FortalCheckboxSize.size1,
        FortalCheckboxSize.size2,
        FortalCheckboxSize.size3,
      ]);
      expect(FortalCheckboxVariant.values, [
        FortalCheckboxVariant.classic,
        FortalCheckboxVariant.surface,
        FortalCheckboxVariant.soft,
      ]);
      expect(FortalRadioSize.values, [
        FortalRadioSize.size1,
        FortalRadioSize.size2,
        FortalRadioSize.size3,
      ]);
      expect(FortalRadioVariant.values, [
        FortalRadioVariant.classic,
        FortalRadioVariant.surface,
        FortalRadioVariant.soft,
      ]);
      expect(FortalSwitchSize.values, [
        FortalSwitchSize.size1,
        FortalSwitchSize.size2,
        FortalSwitchSize.size3,
      ]);
      expect(FortalSwitchVariant.values, [
        FortalSwitchVariant.classic,
        FortalSwitchVariant.surface,
        FortalSwitchVariant.soft,
      ]);
      expect(FortalProgressSize.values, [
        FortalProgressSize.size1,
        FortalProgressSize.size2,
        FortalProgressSize.size3,
      ]);
      expect(FortalProgressVariant.values, [
        FortalProgressVariant.classic,
        FortalProgressVariant.surface,
        FortalProgressVariant.soft,
      ]);
      expect(FortalSpinnerSize.values, [
        FortalSpinnerSize.size1,
        FortalSpinnerSize.size2,
        FortalSpinnerSize.size3,
      ]);
      expect(FortalTextFieldSize.values, [
        FortalTextFieldSize.size1,
        FortalTextFieldSize.size2,
        FortalTextFieldSize.size3,
      ]);
      expect(FortalTextFieldVariant.values, [
        FortalTextFieldVariant.classic,
        FortalTextFieldVariant.surface,
        FortalTextFieldVariant.soft,
      ]);

      const iconButton = FortalIconButton(
        semanticLabel: 'Add',
        icon: Icon(Icons.add),
      );
      const checkbox = FortalCheckbox(selected: false);
      const radio = FortalRadio<int>(value: 1);
      const switchControl = FortalSwitch(selected: false);
      const progress = FortalProgress();
      const spinner = FortalSpinner();
      const textField = FortalTextField();

      expect(iconButton.size, FortalIconButtonSize.size2);
      expect(iconButton.variant, FortalIconButtonVariant.solid);
      expect(checkbox.size, FortalCheckboxSize.size2);
      expect(checkbox.variant, FortalCheckboxVariant.surface);
      expect(radio.size, FortalRadioSize.size2);
      expect(radio.variant, FortalRadioVariant.surface);
      expect(switchControl.size, FortalSwitchSize.size2);
      expect(switchControl.variant, FortalSwitchVariant.surface);
      expect(progress.size, FortalProgressSize.size2);
      expect(progress.variant, FortalProgressVariant.surface);
      expect(spinner.size, FortalSpinnerSize.size2);
      expect(spinner.loading, isTrue);
      expect(textField.size, FortalTextFieldSize.size2);
      expect(textField.variant, FortalTextFieldVariant.surface);
    });

    testWidgets('icon button sizes resolve exact square and icon metrics', (
      tester,
    ) async {
      const expected = <FortalIconButtonSize, (double, double)>{
        FortalIconButtonSize.size1: (24, 12),
        FortalIconButtonSize.size2: (32, 16),
        FortalIconButtonSize.size3: (40, 20),
        FortalIconButtonSize.size4: (48, 24),
      };

      for (final entry in expected.entries) {
        final resolved = await _resolveFortal(
          tester,
          (context) => fortalIconButtonStyler(size: entry.key).build(context),
        );
        final constraints = resolved.spec.container.spec.constraints!;
        expect(
          constraints,
          BoxConstraints.tightFor(
            width: entry.value.$1,
            height: entry.value.$1,
          ),
        );
        expect(resolved.spec.icon.spec.size, entry.value.$2);
      }
    });

    testWidgets('checkbox and radio sizes resolve exact control metrics', (
      tester,
    ) async {
      const expectedCheckbox = <FortalCheckboxSize, (double, double)>{
        FortalCheckboxSize.size1: (14, 9),
        FortalCheckboxSize.size2: (16, 10),
        FortalCheckboxSize.size3: (20, 12),
      };
      const expectedRadio = <FortalRadioSize, (double, double)>{
        FortalRadioSize.size1: (14, 5.6),
        FortalRadioSize.size2: (16, 6.4),
        FortalRadioSize.size3: (20, 8),
      };

      for (final entry in expectedCheckbox.entries) {
        final resolved = await _resolveFortal(
          tester,
          (context) => fortalCheckboxStyler(size: entry.key).build(context),
        );
        expect(
          resolved.spec.container.spec.constraints,
          BoxConstraints.tightFor(
            width: entry.value.$1,
            height: entry.value.$1,
          ),
        );
        expect(resolved.spec.indicator.spec.size, entry.value.$2);
      }

      for (final entry in expectedRadio.entries) {
        final resolved = await _resolveFortal(
          tester,
          (context) => fortalRadioStyler(size: entry.key).build(context),
        );
        expect(
          resolved.spec.container.spec.constraints,
          BoxConstraints.tightFor(
            width: entry.value.$1,
            height: entry.value.$1,
          ),
        );
        expect(
          resolved.spec.indicator.spec.constraints,
          BoxConstraints.tightFor(
            width: entry.value.$2,
            height: entry.value.$2,
          ),
        );
      }
    });

    testWidgets('switch sizes resolve exact track and thumb metrics', (
      tester,
    ) async {
      const expected = <FortalSwitchSize, (double, double, double)>{
        FortalSwitchSize.size1: (28, 16, 14),
        FortalSwitchSize.size2: (35, 20, 18),
        FortalSwitchSize.size3: (42, 24, 22),
      };

      for (final entry in expected.entries) {
        final resolved = await _resolveFortal(
          tester,
          (context) => fortalSwitchStyler(size: entry.key).build(context),
        );
        expect(
          resolved.spec.container.spec.constraints,
          BoxConstraints.tightFor(
            width: entry.value.$1,
            height: entry.value.$2,
          ),
        );
        expect(
          resolved.spec.thumb.spec.constraints,
          BoxConstraints.tightFor(
            width: entry.value.$3,
            height: entry.value.$3,
          ),
        );
      }
    });

    testWidgets('progress and spinner sizes resolve exact metrics', (
      tester,
    ) async {
      const progressHeights = <FortalProgressSize, double>{
        FortalProgressSize.size1: 4,
        FortalProgressSize.size2: 6,
        FortalProgressSize.size3: 8,
      };
      const spinnerSizes = <FortalSpinnerSize, double>{
        FortalSpinnerSize.size1: 12,
        FortalSpinnerSize.size2: 16,
        FortalSpinnerSize.size3: 20,
      };

      for (final entry in progressHeights.entries) {
        final resolved = await _resolveFortal(
          tester,
          (context) => fortalProgressStyler(size: entry.key).build(context),
        );
        expect(
          resolved.spec.container.spec.constraints?.maxHeight,
          entry.value,
        );
        expect(resolved.spec.track.spec.constraints?.maxHeight, entry.value);
        expect(
          resolved.spec.indicator.spec.constraints?.maxHeight,
          entry.value,
        );
      }

      for (final entry in spinnerSizes.entries) {
        final resolved = await _resolveFortal(
          tester,
          (context) => fortalSpinnerStyler(size: entry.key).build(context),
        );
        expect(resolved.spec.size, entry.value);
        expect(resolved.spec.opacity, 0.65);
        expect(resolved.spec.duration, const Duration(milliseconds: 800));
      }
    });

    testWidgets('text field size and variant matrix resolves exact metrics', (
      tester,
    ) async {
      const expectedHeights = <FortalTextFieldSize, double>{
        FortalTextFieldSize.size1: 24,
        FortalTextFieldSize.size2: 32,
        FortalTextFieldSize.size3: 40,
      };
      final recipes =
          <({Color? color, RemixBoxEffectsSpec? containerEffects})>{};

      for (final variant in FortalTextFieldVariant.values) {
        for (final entry in expectedHeights.entries) {
          final resolved = await _resolveFortal(
            tester,
            (context) => fortalTextFieldStyler(
              variant: variant,
              size: entry.key,
            ).build(context),
          );
          expect(
            resolved.spec.container.spec.box?.spec.constraints?.maxHeight,
            entry.value,
            reason: '$variant ${entry.key}',
          );
          expect(resolved.spec.containerEffects?.behindContent, isNotNull);
          if (entry.key == FortalTextFieldSize.size2) {
            final decoration =
                resolved.spec.container.spec.box!.spec.decoration
                    as BoxDecoration;
            recipes.add((
              color: decoration.color,
              containerEffects: resolved.spec.containerEffects,
            ));
          }
        }
      }

      expect(recipes, hasLength(FortalTextFieldVariant.values.length));
    });
  });
}

Future<T> _resolveFortal<T>(
  WidgetTester tester,
  T Function(BuildContext context) resolve,
) async {
  late T result;
  await tester.pumpRemixApp(
    Builder(
      builder: (context) {
        result = resolve(context);
        return const SizedBox.shrink();
      },
    ),
  );
  return result;
}
