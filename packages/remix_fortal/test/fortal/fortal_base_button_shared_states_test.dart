import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  group('Fortal BaseButton shared states', () {
    late FocusHighlightStrategy previousHighlightStrategy;

    setUp(() {
      previousHighlightStrategy = FocusManager.instance.highlightStrategy;
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTraditional;
    });

    tearDown(() {
      FocusManager.instance.highlightStrategy = previousHighlightStrategy;
    });

    for (final variants in _variantPairs) {
      for (final highContrast in [false, true]) {
        testWidgets('${variants.button.name} shared states match'
            '${highContrast ? ' at high contrast' : ''}', (tester) async {
          for (final stateCase in _stateCases) {
            final resolved = await _resolveBaseButtons(
              tester,
              buttonVariant: variants.button,
              iconButtonVariant: variants.iconButton,
              highContrast: highContrast,
              states: stateCase.states,
            );
            final reason =
                '${variants.button.name}/${stateCase.name}'
                '${highContrast ? '/highContrast' : ''}';

            expect(
              _buttonBackground(resolved.button),
              _iconButtonBackground(resolved.iconButton),
              reason: '$reason background',
            );
            expect(
              resolved.button.spec.containerEffects,
              resolved.iconButton.spec.containerEffects,
              reason: '$reason effects',
            );
            expect(
              resolved.button.widgetModifiers,
              resolved.iconButton.widgetModifiers,
              reason: '$reason filters',
            );

            final iconForeground = resolved.iconButton.spec.icon.spec.color;
            expect(
              resolved.button.spec.label.spec.style?.color,
              iconForeground,
              reason: '$reason label foreground',
            );
            expect(
              resolved.button.spec.icon.spec.color,
              iconForeground,
              reason: '$reason icon foreground',
            );
            expect(
              resolved.button.spec.spinner.spec.color,
              resolved.iconButton.spec.spinner.spec.color,
              reason: '$reason spinner foreground',
            );
            expect(
              resolved.button.spec.spinner.spec.opacity,
              resolved.iconButton.spec.spinner.spec.opacity,
              reason: '$reason spinner opacity',
            );

            if (stateCase.name == 'focused') {
              final effects = resolved.button.spec.containerEffects!;
              expect(effects.outline.width, 2, reason: '$reason focus width');
              expect(
                effects.outlineOffset,
                variants.button == .classic || variants.button == .solid
                    ? 2
                    : -1,
                reason: '$reason focus offset',
              );
            } else if (stateCase.name == 'focused+disabled') {
              expect(
                resolved.button.spec.containerEffects?.outline.style,
                BorderStyle.none,
                reason: '$reason disabled focus precedence',
              );
            }
          }
        });
      }
    }

    testWidgets('classic pressed content offset matches at every size', (
      tester,
    ) async {
      for (final sizes in _sizePairs) {
        final resolved = await _resolveBaseButtons(
          tester,
          buttonVariant: .classic,
          iconButtonVariant: .classic,
          buttonSize: sizes.button,
          iconButtonSize: sizes.iconButton,
          states: const {WidgetState.pressed},
        );
        final buttonPadding =
            resolved.button.spec.container.spec.box?.spec.padding as EdgeInsets;
        final iconButtonPadding =
            resolved.iconButton.spec.container.spec.padding as EdgeInsets;

        expect(
          buttonPadding.top,
          sizes.pressedOffset,
          reason: sizes.button.name,
        );
        expect(
          iconButtonPadding.top,
          sizes.pressedOffset,
          reason: sizes.iconButton.name,
        );
      }
    });
  });
}

const _variantPairs =
    <({FortalButtonVariant button, FortalIconButtonVariant iconButton})>[
      (button: .classic, iconButton: .classic),
      (button: .solid, iconButton: .solid),
      (button: .soft, iconButton: .soft),
      (button: .surface, iconButton: .surface),
      (button: .outline, iconButton: .outline),
      (button: .ghost, iconButton: .ghost),
    ];

const _sizePairs =
    <
      ({
        FortalButtonSize button,
        FortalIconButtonSize iconButton,
        double pressedOffset,
      })
    >[
      (button: .size1, iconButton: .size1, pressedOffset: 1),
      (button: .size2, iconButton: .size2, pressedOffset: 2),
      (button: .size3, iconButton: .size3, pressedOffset: 2),
      (button: .size4, iconButton: .size4, pressedOffset: 2),
    ];

const _stateCases = <({String name, Set<WidgetState> states})>[
  (name: 'idle', states: <WidgetState>{}),
  (name: 'hovered', states: {WidgetState.hovered}),
  (name: 'pressed', states: {WidgetState.pressed}),
  (name: 'focused', states: {WidgetState.focused}),
  (name: 'disabled', states: {WidgetState.disabled}),
  (
    name: 'focused+disabled',
    states: {WidgetState.focused, WidgetState.disabled},
  ),
];

Future<({StyleSpec<ButtonSpec> button, StyleSpec<IconButtonSpec> iconButton})>
_resolveBaseButtons(
  WidgetTester tester, {
  required FortalButtonVariant buttonVariant,
  required FortalIconButtonVariant iconButtonVariant,
  FortalButtonSize buttonSize = .size2,
  FortalIconButtonSize iconButtonSize = .size2,
  bool highContrast = false,
  Set<WidgetState> states = const {},
}) async {
  late ({StyleSpec<ButtonSpec> button, StyleSpec<IconButtonSpec> iconButton})
  resolved;

  await tester.pumpWidget(
    FortalScope(
      child: WidgetsApp(
        color: Colors.black,
        builder: (context, child) => WidgetStateProvider(
          states: states,
          child: Builder(
            builder: (context) {
              resolved = (
                button: fortalButtonStyle(
                  variant: buttonVariant,
                  size: buttonSize,
                  highContrast: highContrast,
                ).build(context),
                iconButton: fortalIconButtonStyle(
                  variant: iconButtonVariant,
                  size: iconButtonSize,
                  highContrast: highContrast,
                ).build(context),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ),
  );

  return resolved;
}

Color? _buttonBackground(StyleSpec<ButtonSpec> style) =>
    (style.spec.container.spec.box?.spec.decoration as BoxDecoration?)?.color;

Color? _iconButtonBackground(StyleSpec<IconButtonSpec> style) =>
    (style.spec.container.spec.decoration as BoxDecoration?)?.color;
