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
    (CarbonLayoutScope.maybeSizeOf(context) ?? CarbonSize.lg)
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

/// Carbon's square icon-button recipe.
IconButtonStyler carbonIconButtonStyle({
  CarbonButtonKind kind = .ghost,
  CarbonSize? size,
  bool loading = false,
}) {
  final extent = size == null
      ? _carbonButtonHeight()
      : size.clampTo(.sm, .x2l).height;
  final base = IconButtonStyler()
      .size(extent, extent)
      .borderRadius(.all(.zero))
      .icon(.size(CarbonTokens.iconSize01()))
      .spinner(.size(CarbonTokens.iconSize01()).strokeWidth(2))
      .onFocusVisible(
        .foregroundDecoration(
          ShapeDecorationMix.create(
            shape: Prop.token(_carbonButtonFocusBorder),
          ),
        ),
      );

  return switch (kind) {
    .primary => _fillIconStyle(
      base,
      fill: CarbonComponentTokens.buttonPrimary,
      hover: CarbonComponentTokens.buttonPrimaryHover,
      active: CarbonComponentTokens.buttonPrimaryActive,
      loading: loading,
    ),
    .secondary => _fillIconStyle(
      base,
      fill: CarbonComponentTokens.buttonSecondary,
      hover: CarbonComponentTokens.buttonSecondaryHover,
      active: CarbonComponentTokens.buttonSecondaryActive,
      loading: loading,
    ),
    .danger => _fillIconStyle(
      base,
      fill: CarbonComponentTokens.buttonDangerPrimary,
      hover: CarbonComponentTokens.buttonDangerHover,
      active: CarbonComponentTokens.buttonDangerActive,
      loading: loading,
    ),
    .tertiary => _outlineIconStyle(
      base,
      line: CarbonComponentTokens.buttonTertiary,
      hover: CarbonComponentTokens.buttonTertiaryHover,
      active: CarbonComponentTokens.buttonTertiaryActive,
      loading: loading,
    ),
    .dangerTertiary => _outlineIconStyle(
      base,
      line: CarbonComponentTokens.buttonDangerSecondary,
      hover: CarbonComponentTokens.buttonDangerHover,
      active: CarbonComponentTokens.buttonDangerActive,
      loading: loading,
    ),
    .ghost => _ghostIconStyle(
      base,
      foreground: CarbonTokens.linkPrimary,
      hoverFill: CarbonTokens.backgroundHover,
      hoverForeground: CarbonTokens.linkPrimaryHover,
      activeFill: CarbonTokens.backgroundActive,
      activeForeground: CarbonTokens.linkPrimaryHover,
      loading: loading,
    ),
    .dangerGhost => _ghostIconStyle(
      base,
      foreground: CarbonComponentTokens.buttonDangerSecondary,
      hoverFill: CarbonComponentTokens.buttonDangerHover,
      hoverForeground: CarbonTokens.textOnColor,
      activeFill: CarbonComponentTokens.buttonDangerActive,
      activeForeground: CarbonTokens.textOnColor,
      loading: loading,
    ),
  };
}

/// An icon-only Carbon action with an explicit accessible name.
class CarbonIconButton extends StatelessWidget {
  const CarbonIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    this.kind = .ghost,
    this.size,
    this.loading = false,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
    this.style = const IconButtonStyler.create(),
  }) : assert(semanticLabel != '');

  final IconData icon;
  final String semanticLabel;
  final CarbonButtonKind kind;
  final CarbonSize? size;
  final bool loading;
  final bool enabled;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enableFeedback;
  final String? semanticHint;
  final bool excludeSemantics;
  final MouseCursor mouseCursor;
  final IconButtonStyler style;

  @override
  Widget build(BuildContext context) =>
      carbonIconButtonStyle(
        kind: kind,
        size: size,
        loading: loading,
      ).merge(style)(
        icon: icon,
        semanticLabel: semanticLabel,
        loading: loading,
        enabled: enabled,
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autofocus,
        enableFeedback: enableFeedback,
        semanticHint: semanticHint,
        excludeSemantics: excludeSemantics,
        mouseCursor: mouseCursor,
      );
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

IconButtonStyler _fillIconStyle(
  IconButtonStyler base, {
  required ColorToken fill,
  required ColorToken hover,
  required ColorToken active,
  required bool loading,
}) => base
    .color(fill())
    .icon(.color(CarbonTokens.textOnColor()))
    .spinner(.indicatorColor(CarbonTokens.textOnColor()))
    .onHovered(.color(hover()))
    .onPressed(.color(active()))
    .onDisabled(
      loading
          ? IconButtonStyler()
                .color(fill())
                .spinner(.indicatorColor(CarbonTokens.textOnColor()))
          : IconButtonStyler()
                .color(CarbonComponentTokens.buttonDisabled())
                .icon(.color(CarbonTokens.textOnColorDisabled())),
    );

IconButtonStyler _outlineIconStyle(
  IconButtonStyler base, {
  required ColorToken line,
  required ColorToken hover,
  required ColorToken active,
  required bool loading,
}) => base
    .color(const Color(0x00000000))
    .border(.color(line()).width(1))
    .icon(.color(line()))
    .spinner(.indicatorColor(line()))
    .onHovered(
      IconButtonStyler()
          .color(hover())
          .icon(.color(CarbonTokens.textInverse())),
    )
    .onPressed(
      IconButtonStyler()
          .color(active())
          .icon(.color(CarbonTokens.textInverse())),
    )
    .onDisabled(
      loading
          ? IconButtonStyler()
                .border(.color(line()).width(1))
                .spinner(.indicatorColor(line()))
          : IconButtonStyler()
                .border(.color(CarbonTokens.borderDisabled()).width(1))
                .icon(.color(CarbonTokens.iconDisabled())),
    );

IconButtonStyler _ghostIconStyle(
  IconButtonStyler base, {
  required ColorToken foreground,
  required ColorToken hoverFill,
  required ColorToken hoverForeground,
  required ColorToken activeFill,
  required ColorToken activeForeground,
  required bool loading,
}) => base
    .color(const Color(0x00000000))
    .icon(.color(foreground()))
    .spinner(.indicatorColor(foreground()))
    .onHovered(
      IconButtonStyler().color(hoverFill()).icon(.color(hoverForeground())),
    )
    .onPressed(
      IconButtonStyler().color(activeFill()).icon(.color(activeForeground())),
    )
    .onDisabled(
      loading
          ? IconButtonStyler().spinner(.indicatorColor(foreground()))
          : IconButtonStyler().icon(.color(CarbonTokens.iconDisabled())),
    );
