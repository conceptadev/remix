import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layout_scope.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../../tokens/generated/carbon_component_tokens.g.dart';

part 'carbon_button.g.dart';

/// Carbon button kinds.
///
/// Mirrors Carbon's button variants rather than Fortal/Remix naming. See the
/// worksheet at `specs/components/button.yaml`.
enum CarbonButtonKind {
  primary,
  secondary,
  tertiary,
  ghost,
  danger,
  dangerTertiary,
  dangerGhost,
}

const _carbonButtonFocusBorder = ContextToken(_resolveCarbonButtonFocusBorder);

const _carbonButtonHeight = ContextToken(_resolveCarbonButtonHeight);

double _resolveCarbonButtonHeight(BuildContext context) =>
    (CarbonLayoutScope.maybeOf(context)?.size ?? CarbonSize.lg)
        .clampTo(.sm, .x2l)
        .height;

ShapeBorder _resolveCarbonButtonFocusBorder(BuildContext context) {
  final outer = RoundedRectangleBorder(
    side: BorderSide(color: CarbonTokens.focus.resolve(context), width: 2.0),
  );
  final inner = RoundedRectangleBorder(
    side: BorderSide(
      color: CarbonTokens.focusInset.resolve(context),
      width: 1.0,
    ),
  );

  // Flutter lists compound shape borders outside-in. The left operand is the
  // inner border and the right operand is the outer border.
  return inner + outer;
}

/// A Carbon button recipe and generated [RemixButton] wrapper.
///
/// Consumes Carbon component and role tokens; resolves inside a `CarbonScope`.
/// Carbon buttons use square corners (radius 0) and the `body-compact-01` label
/// style. When [size] is null, height comes from `CarbonLayoutScope`, falling
/// back to Carbon's `lg` (48px), and is clamped to the supported `sm`–`2xl`
/// range.
///
/// Pass [loading] when the button renders a loading spinner: Remix folds
/// loading into the disabled widget-state, and a loading Carbon button keeps
/// its kind's colors (with a `textOnColor` spinner) instead of the disabled
/// gray treatment.
@MixWidget(
  target: RemixButton.new,
  widgetParameters: .only({
    'label',
    'trailingIcon',
    'loading',
    'enabled',
    'onPressed',
    'onLongPress',
    'focusNode',
    'autofocus',
    'enableFeedback',
    'semanticLabel',
    'semanticHint',
    'excludeSemantics',
    'mouseCursor',
  }),
)
ButtonStyler carbonButtonStyle({
  CarbonButtonKind kind = .primary,
  CarbonSize? size,
  bool loading = false,
}) {
  final height = size == null
      ? _carbonButtonHeight()
      : size.clampTo(.sm, .x2l).height;
  final base = _carbonButtonBaseStyle(height, kind);

  return switch (kind) {
    .primary => _fillStyle(
      base,
      fill: CarbonComponentTokens.buttonPrimary,
      hover: CarbonComponentTokens.buttonPrimaryHover,
      active: CarbonComponentTokens.buttonPrimaryActive,
      loading: loading,
    ),
    .secondary => _fillStyle(
      base,
      fill: CarbonComponentTokens.buttonSecondary,
      hover: CarbonComponentTokens.buttonSecondaryHover,
      active: CarbonComponentTokens.buttonSecondaryActive,
      loading: loading,
    ),
    .danger => _fillStyle(
      base,
      fill: CarbonComponentTokens.buttonDangerPrimary,
      hover: CarbonComponentTokens.buttonDangerHover,
      active: CarbonComponentTokens.buttonDangerActive,
      loading: loading,
    ),
    .tertiary => _outlineStyle(
      base,
      line: CarbonComponentTokens.buttonTertiary,
      hover: CarbonComponentTokens.buttonTertiaryHover,
      active: CarbonComponentTokens.buttonTertiaryActive,
      interactionText: CarbonTokens.textInverse,
      focusFill: CarbonComponentTokens.buttonTertiary,
      focusText: CarbonTokens.textInverse,
      loading: loading,
    ),
    .dangerTertiary => _outlineStyle(
      base,
      line: CarbonComponentTokens.buttonDangerSecondary,
      hover: CarbonComponentTokens.buttonDangerHover,
      active: CarbonComponentTokens.buttonDangerActive,
      interactionText: CarbonTokens.textOnColor,
      focusFill: CarbonComponentTokens.buttonDangerPrimary,
      focusText: CarbonTokens.textOnColor,
      loading: loading,
    ),
    .ghost => _ghostStyle(
      base,
      text: CarbonTokens.linkPrimary,
      hoverFill: CarbonTokens.backgroundHover,
      hoverText: CarbonTokens.linkPrimaryHover,
      activeFill: CarbonTokens.backgroundActive,
      activeText: CarbonTokens.linkPrimaryHover,
      loading: loading,
    ),
    .dangerGhost => _ghostStyle(
      base,
      text: CarbonComponentTokens.buttonDangerSecondary,
      hoverFill: CarbonComponentTokens.buttonDangerHover,
      hoverText: CarbonTokens.textOnColor,
      activeFill: CarbonComponentTokens.buttonDangerActive,
      activeText: CarbonTokens.textOnColor,
      loading: loading,
    ),
  };
}

// Carbon buttons share height, padding, label typography and focus ring.
ButtonStyler _carbonButtonBaseStyle(double height, CarbonButtonKind kind) {
  return ButtonStyler()
      .height(height)
      .padding(.horizontal(CarbonTokens.spacing05()))
      .spacing(switch (kind) {
        .ghost || .dangerGhost => CarbonTokens.spacing03(),
        .primary ||
        .secondary ||
        .tertiary ||
        .danger ||
        .dangerTertiary => CarbonTokens.spacing07(),
      })
      // Carbon justifies label/icon to opposite edges when the button is
      // given a width; shrink-wrapped buttons are unaffected.
      .mainAxisAlignment(.spaceBetween)
      .borderRadius(.all(.zero))
      // Label consumes the body-compact-01 token, so upstream type changes and
      // the scope's fontFamily override flow through without hand-synced values.
      .label(TextStyler().style(CarbonTokens.bodyCompact01.mix()))
      .icon(IconStyler().size(CarbonTokens.iconSize01()))
      .spinner(.size(CarbonTokens.iconSize01()).strokeWidth(2.0))
      // Carbon's focus ring is an inset box-shadow. Painting it as a
      // foreground-decoration border keeps layout stable (no padding change)
      // and leaves each kind's own border intact.
      .onFocusVisible(
        .foregroundDecoration(
          ShapeDecorationMix.create(
            shape: Prop.token(_carbonButtonFocusBorder),
          ),
        ),
      );
}

// Solid-fill kinds (primary, secondary, danger): white-on-color label.
ButtonStyler _fillStyle(
  ButtonStyler base, {
  required ColorToken fill,
  required ColorToken hover,
  required ColorToken active,
  required bool loading,
}) {
  // Loading buttons are non-interactive (Remix maps loading to the disabled
  // state) but keep their kind's fill with a textOnColor spinner.
  final disabledStyle = loading
      ? ButtonStyler()
            .color(fill())
            .spinner(.indicatorColor(CarbonTokens.textOnColor()))
      : _disabledFill();

  return _foreground(base, CarbonTokens.textOnColor())
      .color(fill())
      .spinner(.indicatorColor(CarbonTokens.textOnColor()))
      .onHovered(.color(hover()))
      .onPressed(.color(active()))
      .onDisabled(disabledStyle);
}

// Outline kinds (tertiary, danger tertiary): colored border + text, fills on hover.
ButtonStyler _outlineStyle(
  ButtonStyler base, {
  required ColorToken line,
  required ColorToken hover,
  required ColorToken active,
  required ColorToken interactionText,
  required ColorToken focusFill,
  required ColorToken focusText,
  required bool loading,
}) {
  final disabledStyle = loading
      ? ButtonStyler()
            .color(const Color(0x00000000))
            .border(.color(line()).width(1.0))
            .spinner(.indicatorColor(line()))
      : _foreground(
          ButtonStyler()
              .color(const Color(0x00000000))
              .border(.color(CarbonTokens.borderDisabled()).width(1.0)),
          CarbonTokens.textDisabled(),
        );

  return _foreground(base, line())
      .color(const Color(0x00000000))
      .border(.color(line()).width(1.0))
      .spinner(.indicatorColor(line()))
      .onHovered(_foreground(.color(hover()), interactionText()))
      .onPressed(_foreground(.color(active()), interactionText()))
      .onFocusVisible(_foreground(.color(focusFill()), focusText()))
      .onDisabled(disabledStyle);
}

// Ghost kinds: transparent, colored text, per-kind hover/active fills.
ButtonStyler _ghostStyle(
  ButtonStyler base, {
  required ColorToken text,
  required ColorToken hoverFill,
  required ColorToken hoverText,
  required ColorToken activeFill,
  required ColorToken activeText,
  required bool loading,
}) {
  final disabledStyle = loading
      ? ButtonStyler().spinner(.indicatorColor(text()))
      : _foreground(ButtonStyler(), CarbonTokens.textDisabled());

  return _foreground(base, text())
      .color(const Color(0x00000000))
      .spinner(.indicatorColor(text()))
      .onHovered(_foreground(.color(hoverFill()), hoverText()))
      .onPressed(_foreground(.color(activeFill()), activeText()))
      .onDisabled(disabledStyle);
}

ButtonStyler _disabledFill() => _foreground(
  ButtonStyler()
      .color(CarbonComponentTokens.buttonDisabled())
      .spinner(
        .indicatorColor(CarbonTokens.textOnColorDisabled()).strokeWidth(1.0),
      ),
  CarbonTokens.textOnColorDisabled(),
);

ButtonStyler _foreground(ButtonStyler style, Color color) =>
    style.label(.color(color)).icon(.color(color));
