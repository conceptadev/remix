import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layout_scope.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../../tokens/generated/carbon_component_tokens.g.dart';

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

// Styles are pure functions of (kind, size, loading); the full input space is
// 7 x 5 x 2 immutable stylers, so they are built once and shared.
final Map<(CarbonButtonKind, CarbonSize, bool), ButtonStyler> _styleCache = {};

const _carbonButtonFocusBorder = ContextToken(_resolveCarbonButtonFocusBorder);

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

/// Builds a Carbon-themed [ButtonStyler] for a [kind] and [size].
///
/// Consumes Carbon component and role tokens; resolves inside a `CarbonScope`.
/// Carbon buttons use square corners (radius 0) and the `body-compact-01` label
/// style. Heights come from the Carbon control-size scale.
///
/// Pass [loading] when the button renders a loading spinner: Remix folds
/// loading into the disabled widget-state, and a loading Carbon button keeps
/// its kind's colors (with a `textOnColor` spinner) instead of the disabled
/// gray treatment.
ButtonStyler carbonButtonStyler({
  CarbonButtonKind kind = .primary,
  CarbonSize size = .lg,
  bool loading = false,
}) {
  final clamped = size.clampTo(.sm, .x2l);

  return _styleCache.putIfAbsent((kind, clamped, loading), () {
    final base = _carbonButtonBaseStyle(clamped, kind);

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
  });
}

// Carbon buttons share height, padding, label typography and focus ring.
ButtonStyler _carbonButtonBaseStyle(CarbonSize size, CarbonButtonKind kind) {
  return ButtonStyler()
      .height(size.height)
      .paddingX(CarbonTokens.spacing05())
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
      .borderRadiusAll(.zero)
      // Label consumes the body-compact-01 token, so upstream type changes and
      // the scope's fontFamily override flow through without hand-synced values.
      .label(TextStyler().style(CarbonTokens.bodyCompact01.mix()))
      .icon(IconStyler().size(CarbonTokens.iconSize01()))
      .spinner(
        RemixSpinnerStyler().size(CarbonTokens.iconSize01()).strokeWidth(2.0),
      )
      // Carbon's focus ring is an inset box-shadow. Painting it as a
      // foreground-decoration border keeps layout stable (no padding change)
      // and leaves each kind's own border intact.
      .onFocused(
        .new().foregroundDecoration(
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
            .spinner(
              RemixSpinnerStyler().indicatorColor(CarbonTokens.textOnColor()),
            )
      : _disabledFill();

  return base
      .color(fill())
      .foregroundColor(CarbonTokens.textOnColor())
      .spinner(RemixSpinnerStyler().indicatorColor(CarbonTokens.textOnColor()))
      .onHovered(ButtonStyler().color(hover()))
      .onPressed(ButtonStyler().color(active()))
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
            .borderAll(color: line(), width: 1.0)
            .spinner(RemixSpinnerStyler().indicatorColor(line()))
      : ButtonStyler()
            .color(const Color(0x00000000))
            .borderAll(color: CarbonTokens.borderDisabled(), width: 1.0)
            .foregroundColor(CarbonTokens.textDisabled());

  return base
      .color(const Color(0x00000000))
      .borderAll(color: line(), width: 1.0)
      .foregroundColor(line())
      .spinner(RemixSpinnerStyler().indicatorColor(line()))
      .onHovered(
        ButtonStyler().color(hover()).foregroundColor(interactionText()),
      )
      .onPressed(
        ButtonStyler().color(active()).foregroundColor(interactionText()),
      )
      .onFocused(.new().color(focusFill()).foregroundColor(focusText()))
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
      ? ButtonStyler().spinner(RemixSpinnerStyler().indicatorColor(text()))
      : ButtonStyler().foregroundColor(CarbonTokens.textDisabled());

  return base
      .color(const Color(0x00000000))
      .foregroundColor(text())
      .spinner(RemixSpinnerStyler().indicatorColor(text()))
      .onHovered(ButtonStyler().color(hoverFill()).foregroundColor(hoverText()))
      .onPressed(
        ButtonStyler().color(activeFill()).foregroundColor(activeText()),
      )
      .onDisabled(disabledStyle);
}

ButtonStyler _disabledFill() {
  return ButtonStyler()
      .color(CarbonComponentTokens.buttonDisabled())
      .foregroundColor(CarbonTokens.textOnColorDisabled())
      .spinner(
        RemixSpinnerStyler()
            .indicatorColor(CarbonTokens.textOnColorDisabled())
            .strokeWidth(1.0),
      );
}

/// A Carbon button.
///
/// ```dart
/// CarbonButton(
///   label: 'Save',
///   kind: CarbonButtonKind.primary,
///   onPressed: () {},
/// )
/// ```
///
/// Resolve inside a `CarbonScope`. When [size] is null, the button inherits the
/// contextual size from an enclosing `CarbonLayoutScope`; without one it uses
/// Carbon's default button size (`lg`, 48px). Either way the size is clamped to
/// the range Carbon buttons support (`sm`–`2xl`).
class CarbonButton extends StatelessWidget {
  const CarbonButton({
    super.key,
    required this.label,
    this.kind = CarbonButtonKind.primary,
    this.size,
    this.icon,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  });

  /// Button text.
  final String label;

  /// Carbon button kind.
  final CarbonButtonKind kind;

  /// Explicit size; when null, inherits from `CarbonLayoutScope` or defaults
  /// to Carbon's `lg`.
  final CarbonSize? size;

  /// Optional trailing icon (Carbon places button icons after the label).
  final IconData? icon;

  /// Whether to show a loading spinner in place of interaction.
  final bool loading;

  /// Whether the button is enabled.
  final bool enabled;

  final bool enableFeedback;

  /// Pressed callback. A null callback also renders the button as disabled.
  final VoidCallback? onPressed;

  /// Callback invoked when the enabled button is long-pressed.
  final VoidCallback? onLongPress;

  /// Optional focus node used by the underlying button behavior.
  final FocusNode? focusNode;

  /// Whether the button requests focus when it is first built.
  final bool autofocus;

  /// Overrides the accessible label (defaults to [label]).
  final String? semanticLabel;

  /// Additional accessible context describing the button's action.
  final String? semanticHint;

  /// Whether descendant semantics are excluded from the button's semantics.
  final bool excludeSemantics;

  /// Cursor shown while hovering over the button.
  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    final effectiveSize =
        size ?? CarbonLayoutScope.maybeOf(context)?.size ?? .lg;

    return carbonButtonStyler(
      kind: kind,
      size: effectiveSize,
      loading: loading,
    ).call(
      label: label,
      trailingIcon: icon,
      loading: loading,
      enabled: enabled,
      enableFeedback: enableFeedback,
      onPressed: onPressed,
      onLongPress: onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      mouseCursor: mouseCursor,
    );
  }
}
