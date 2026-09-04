import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';

/// Carbon link typography sizes.
enum CarbonLinkSize { small, medium, large }

/// An accessible Carbon text link.
///
/// [RemixLink] owns link semantics, focus, and keyboard activation while this
/// facade applies Carbon typography and state tokens.
class CarbonLink extends StatelessWidget {
  const CarbonLink({
    super.key,
    required this.label,
    this.onPressed,
    this.size = .medium,
    this.visited = false,
    this.inline = false,
    this.enabled = true,
    this.linkUrl,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final CarbonLinkSize size;
  final bool visited;
  final bool inline;
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
  Widget build(BuildContext context) => RemixLink(
    label: label,
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
    style: carbonLinkStyle(size: size, visited: visited, inline: inline),
  );
}

final Map<(CarbonLinkSize, bool, bool), LinkStyler> _carbonLinkStyles = {};

/// Carbon's token-backed visual recipe for [RemixLink].
LinkStyler carbonLinkStyle({
  CarbonLinkSize size = .medium,
  bool visited = false,
  bool inline = false,
}) {
  return _carbonLinkStyles.putIfAbsent((size, visited, inline), () {
    final baseColor = visited
        ? CarbonTokens.linkVisited
        : CarbonTokens.linkPrimary;
    final activeOutline = RemixBoxEffectsMix(
      outline: BorderSideMix(
        color: CarbonTokens.focus(),
        width: 2,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      outlineOffset: -2,
    );

    return LinkStyler()
        .padding(
          inline
              ? EdgeInsetsMix.zero
              : EdgeInsetsGeometryMix.symmetric(horizontal: 2, vertical: 1),
        )
        .label(
          TextStyler()
              .style(switch (size) {
                .small => CarbonTokens.helperText01.mix(),
                .medium => CarbonTokens.bodyCompact01.mix(),
                .large => CarbonTokens.bodyCompact02.mix(),
              })
              .color(baseColor())
              .decoration(inline ? .underline : .none),
        )
        .onHovered(
          LinkStyler().label(
            TextStyler()
                .color(CarbonTokens.linkPrimaryHover())
                .decoration(.underline),
          ),
        )
        .onPressed(
          LinkStyler()
              .label(TextStyler().decoration(.underline))
              .containerEffects(activeOutline),
        )
        .onFocusVisible(
          LinkStyler()
              .label(TextStyler().decoration(.underline))
              .containerEffects(activeOutline),
        )
        .onDisabled(
          LinkStyler().label(
            TextStyler()
                .color(CarbonTokens.textDisabled())
                .decoration(inline ? .underline : .none),
          ),
        );
  });
}
