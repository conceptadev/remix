import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';
import 'typography.dart';

/// Underline visibility for [UiLink].
enum UiLinkUnderline { auto, always, hover, none }

/// Ui-themed link style.
///
/// Takes a [context] because the focus outline's radius is em-relative to the
/// resolved font size.
///
/// [actionable] gates every state-dependent rule, matching upstream's
/// `:where(:any-link, button)`. A non-actionable link carries no hover or
/// focus-visible variant at all, so it stays plain accent text no matter what
/// widget states are resolved around it.
LinkStyler uiLinkStyle(
  BuildContext context, {
  UiTextSize? size,
  UiTextWeight? weight,
  UiLinkUnderline underline = .auto,
  bool softWrap = true,
  bool truncate = false,
  bool highContrast = false,
  required bool actionable,
  LinkStyler style = const LinkStyler.create(),
}) {
  LinkStyler styleFor({bool hovered = false, bool focused = false}) =>
      _uiLinkStateStyle(
        context,
        size: size,
        weight: weight,
        underline: underline,
        softWrap: softWrap,
        truncate: truncate,
        highContrast: highContrast,
        actionable: actionable,
        hovered: hovered,
        focused: focused,
      );

  if (!actionable) return styleFor().merge(style);

  // The focus-visible snapshot already drops the underline via `focused`; the
  // explicit `none` also clears any decoration inherited through the merge.
  final focusVisible = styleFor(
    focused: true,
  ).label(.decoration(TextDecoration.none));

  return styleFor()
      .onHovered(styleFor(hovered: true))
      .onFocusVisible(focusVisible)
      .merge(style);
}

/// Resolves one point in the link's state space.
///
/// Separate from [uiLinkStyle] because the public recipe returns a style
/// carrying Mix variants, and building those variants needs the flat snapshots
/// they are built from.
LinkStyler _uiLinkStateStyle(
  BuildContext context, {
  required UiTextSize? size,
  required UiTextWeight? weight,
  required UiLinkUnderline underline,
  required bool softWrap,
  required bool truncate,
  required bool highContrast,
  required bool actionable,
  required bool hovered,
  required bool focused,
}) {
  var textStyle = uiAccentForeground(TextStyler(), highContrast: highContrast);
  // An omitted size anchors to the root `text3` token rather than the ambient
  // `DefaultTextStyle`, so a host text run cannot change the link's metrics or
  // its em-relative underline geometry.
  textStyle = textStyle.style(uiTextSizeToken(size ?? UiTextSize.size3).mix());
  if (weight != null) {
    textStyle = textStyle.fontWeight(uiTextWeightToken(weight)());
  }
  textStyle = textStyle.inherit(false);

  final effectiveText = uiResolveTextToken(context, size ?? UiTextSize.size3);
  final fontSize = effectiveText.fontSize!;

  // Every upstream underline rule is gated behind `:where(:any-link, button)`,
  // so a link with no callback stays plain accent-coloured text. A focus-visible
  // outline replaces the underline rather than stacking both.
  final underlined =
      actionable &&
      !focused &&
      switch (underline) {
        .always => true,
        .hover => hovered,
        .auto => highContrast || hovered,
        .none => false,
      };
  if (underlined) {
    // Radix declares the decoration colour twice for this selector and the
    // later rule wins:
    //   text-decoration-color: color-mix(in oklab, var(--accent-aN), var(--gray-a6))
    // Using the accent alpha alone leaves the underline noticeably fainter, so
    // blend it. Color.lerp is an sRGB approximation of the oklab mix.
    final accentStep = underline == UiLinkUnderline.auto && highContrast
        ? UiTokens.accentA6
        : UiTokens.accentA5;
    final decorationColor = Color.lerp(
      uiResolveColor(context, accentStep),
      uiResolveColor(context, UiTokens.grayA6),
      0.5,
    )!;
    textStyle = textStyle
        .decoration(TextDecoration.underline)
        .decorationStyle(TextDecorationStyle.solid)
        .decorationColor(decorationColor)
        // Upstream is `min(2px, max(1px, 0.05em))`. Flutter reads
        // decorationThickness as a multiple of the font's own underline
        // thickness rather than a length, so the pinned 1–2 range lands as a
        // 1×–2× stroke instead of exact pixels; the em breakpoints still fall
        // where Radix puts them.
        .decorationThickness(math.min(2, math.max(1, 0.05 * fontSize)));
  }
  textStyle = uiApplyTextFlow(
    textStyle,
    softWrap: softWrap,
    truncate: truncate,
  );

  var style = LinkStyler()
      .label(textStyle)
      .borderRadius(
        BorderRadiusGeometryMix.circular(
          0.07 * fontSize * uiRadiusFactor(context),
        ),
      );
  if (focused) {
    style = style.containerEffects(
      uiFocusOutline(uiResolveColor(context, UiTokens.focus8), offset: 2),
    );
  }

  return style;
}

/// Token-backed text that becomes an accessible link only when actionable.
///
/// A null [onPressed] disables the link just as [enabled] `false` does: accent
/// text with no focus stop, link role, or activation, and never underlined.
/// Reach for `UiText(accent: true)` when the text was never meant to
/// navigate.
///
/// `linkUrl` is assistive metadata only and is never launched; navigation stays
/// the caller's responsibility in [onPressed].
///
/// An actionable link activates on pointer and Enter. Space belongs to the
/// Button role and is deliberately left unclaimed.
class UiLink extends StatelessWidget {
  const UiLink(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.underline = UiLinkUnderline.auto,
    this.softWrap = true,
    this.truncate = false,
    this.highContrast = false,
    this.onPressed,
    this.enabled = true,
    this.linkUrl,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.style = const LinkStyler.create(),
  }) : assert(text != ''),
       assert(semanticLabel == null || semanticLabel != ''),
       assert(semanticHint == null || semanticHint != ''),
       assert(linkUrl == null || onPressed != null);

  final String text;
  final UiTextSize? size;
  final UiTextWeight? weight;
  final UiLinkUnderline underline;
  final bool softWrap;
  final bool truncate;
  final bool highContrast;
  final VoidCallback? onPressed;
  final bool enabled;
  final Uri? linkUrl;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enableFeedback;
  final MouseCursor mouseCursor;
  final String? semanticLabel;
  final String? semanticHint;
  final bool excludeSemantics;
  final LinkStyler style;

  @override
  Widget build(BuildContext context) {
    return RemixLink(
      label: text,
      onPressed: onPressed,
      enabled: enabled,
      linkUrl: linkUrl,
      focusNode: focusNode,
      autofocus: autofocus,
      enableFeedback: enableFeedback,
      mouseCursor: mouseCursor,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      style: uiLinkStyle(
        context,
        size: size,
        weight: weight,
        underline: underline,
        softWrap: softWrap,
        truncate: truncate,
        highContrast: highContrast,
        actionable: enabled && onPressed != null,
        style: style,
      ),
    );
  }
}
