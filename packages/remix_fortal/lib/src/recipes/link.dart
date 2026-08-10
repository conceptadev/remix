import 'package:flutter/material.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';
import 'typography_shared.dart';

/// Underline visibility for [FortalLink].
enum FortalLinkUnderline { auto, always, hover, none }

/// Fortal-themed link style.
///
/// Takes a [context] because the focus outline's radius is em-relative to the
/// resolved font size.
BadgeStyler fortalLinkStyle(
  BuildContext context, {
  FortalTextSize? size,
  FortalTextWeight? weight,
  FortalLinkUnderline underline = .auto,
  bool softWrap = true,
  bool truncate = false,
  bool highContrast = false,
  required bool actionable,
  bool hovered = false,
  bool focused = false,
}) {
  var textStyle = fortalAccentForeground(
    TextStyler(),
    highContrast: highContrast,
  );
  if (size != null) {
    textStyle = textStyle.style(fortalTextSizeToken(size).mix());
  }
  if (weight != null) {
    textStyle = textStyle.fontWeight(fortalTextWeightToken(weight)());
  }

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
    final accentStep = underline == FortalLinkUnderline.auto && highContrast
        ? FortalTokens.accentA6
        : FortalTokens.accentA5;
    final decorationColor = Color.lerp(
      fortalResolveColor(context, accentStep),
      fortalResolveColor(context, FortalTokens.grayA6),
      0.5,
    )!;
    textStyle = textStyle
        .decoration(TextDecoration.underline)
        .decorationStyle(TextDecorationStyle.solid)
        .decorationColor(decorationColor);
  }
  textStyle = fortalApplyTextFlow(
    textStyle,
    softWrap: softWrap,
    truncate: truncate,
  );

  final effectiveText = size == null
      ? DefaultTextStyle.of(context).style
      : fortalResolveTextToken(context, size);
  final fontSize = fortalResolvedFontSize(effectiveText);

  var style = BadgeStyler()
      .label(textStyle)
      .borderRadius(
        BorderRadiusGeometryMix.circular(
          0.07 * fontSize * fortalRadiusFactor(context),
        ),
      );
  if (focused) {
    style = style.containerEffects(
      fortalFocusOutline(
        fortalResolveColor(context, FortalTokens.focus8),
        offset: 2,
      ),
    );
  }

  return style;
}

BadgeStyler _fortalInteractiveLinkStyle(
  BuildContext context, {
  FortalTextSize? size,
  FortalTextWeight? weight,
  required FortalLinkUnderline underline,
  required bool softWrap,
  required bool truncate,
  required bool highContrast,
}) {
  BadgeStyler styleFor({bool hovered = false, bool focused = false}) {
    return fortalLinkStyle(
      context,
      size: size,
      weight: weight,
      underline: underline,
      softWrap: softWrap,
      truncate: truncate,
      highContrast: highContrast,
      actionable: true,
      hovered: hovered,
      focused: focused,
    );
  }

  final focusVisible = styleFor(
    focused: true,
  ).label(.decoration(TextDecoration.none));
  return styleFor()
      .onHovered(styleFor(hovered: true))
      .onFocusVisible(focusVisible);
}

/// Token-backed text that becomes an accessible link only when actionable.
///
/// With no [onPressed] this renders inert styled text: no focus stop, link
/// role, or activation. `linkUrl` is assistive metadata only and is never
/// launched; navigation stays the caller's responsibility in [onPressed].
class FortalLink extends StatefulWidget {
  const FortalLink(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.underline = FortalLinkUnderline.auto,
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
  }) : assert(text != ''),
       assert(semanticLabel == null || semanticLabel != ''),
       assert(semanticHint == null || semanticHint != ''),
       assert(linkUrl == null || onPressed != null);

  final String text;
  final FortalTextSize? size;
  final FortalTextWeight? weight;
  final FortalLinkUnderline underline;
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

  @override
  State<FortalLink> createState() => _FortalLinkState();
}

class _FortalLinkState extends State<FortalLink> {
  // Mirrored from NakedButton because the link Semantics node must sit *outside*
  // the button: NakedButton implements `excludeSemantics: true` as an
  // ExcludeSemantics wrapper, which would suppress a node placed inside it.
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    if (widget.onPressed == null) {
      final content = fortalLinkStyle(
        context,
        size: widget.size,
        weight: widget.weight,
        underline: widget.underline,
        softWrap: widget.softWrap,
        truncate: widget.truncate,
        highContrast: widget.highContrast,
        actionable: false,
      )(label: widget.text);

      if (widget.excludeSemantics) return ExcludeSemantics(child: content);
      if (widget.semanticLabel == null) return content;

      return Semantics(
        label: widget.semanticLabel,
        excludeSemantics: true,
        child: content,
      );
    }

    final button = NakedButton(
      onPressed: widget.enabled ? widget.onPressed : null,
      enabled: widget.enabled,
      mouseCursor: widget.mouseCursor,
      enableFeedback: widget.enableFeedback,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onFocusChange: (focused) {
        if (_focused != focused) setState(() => _focused = focused);
      },
      excludeSemantics: true,
      builder: (context, _, _) => StyleBuilder<BadgeSpec>(
        style: _fortalInteractiveLinkStyle(
          context,
          size: widget.size,
          weight: widget.weight,
          underline: widget.underline,
          softWrap: widget.softWrap,
          truncate: widget.truncate,
          highContrast: widget.highContrast,
        ),
        controller: NakedButtonState.controllerOf(context),
        builder: (_, spec) => RemixBadge(label: widget.text, styleSpec: spec),
      ),
    );

    final link = Semantics(
      link: true,
      enabled: widget.enabled,
      focused: _focused,
      linkUrl: widget.linkUrl,
      label: widget.semanticLabel ?? widget.text,
      hint: widget.semanticHint,
      onTap: widget.enabled ? widget.onPressed : null,
      child: button,
    );

    return widget.excludeSemantics ? ExcludeSemantics(child: link) : link;
  }
}
