import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_action_surface.dart';

/// Carbon link typography sizes.
enum CarbonLinkSize { small, medium, large }

/// An accessible Carbon text link.
///
/// Flutter has no material-free link control, so this widget owns the link
/// semantics and keyboard activation while Mix owns its visual state.
class CarbonLink extends StatelessWidget {
  const CarbonLink({
    super.key,
    required this.label,
    this.onPressed,
    this.size = .medium,
    this.visited = false,
    this.inline = false,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final CarbonLinkSize size;
  final bool visited;
  final bool inline;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;

    return CarbonActionSurface(
      semanticLabel: semanticLabel ?? label,
      onPressed: onPressed,
      enabled: enabled,
      focusNode: focusNode,
      autofocus: autofocus,
      excludeChildSemantics: true,
      button: false,
      link: true,
      builder: (context, focused, hovered, _) {
        final baseColor = visited
            ? CarbonTokens.linkVisited
            : CarbonTokens.linkPrimary;
        final textStyle = TextStyler()
            .style(switch (size) {
              .small => CarbonTokens.helperText01.mix(),
              .medium => CarbonTokens.bodyCompact01.mix(),
              .large => CarbonTokens.bodyCompact02.mix(),
            })
            .color(
              enabled
                  ? (hovered ? CarbonTokens.linkPrimaryHover() : baseColor())
                  : CarbonTokens.textDisabled(),
            )
            .decoration(hovered ? .underline : .none);

        return Box(
          style: BoxStyler()
              .padding(
                inline
                    ? EdgeInsetsMix.zero
                    : EdgeInsetsGeometryMix.symmetric(
                        horizontal: 2,
                        vertical: 1,
                      ),
              )
              .border(
                BoxBorderMix.all(
                  BorderSideMix(
                    color: focused && enabled
                        ? CarbonTokens.focus()
                        : const Color(0x00000000),
                    width: 2,
                  ),
                ),
              ),
          child: StyledText(label, style: textStyle),
        );
      },
    );
  }
}
