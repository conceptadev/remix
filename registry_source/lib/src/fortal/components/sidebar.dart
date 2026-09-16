import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';
import 'text.dart';
import 'toggle.dart';
import 'tooltip.dart';

part 'sidebar.g.dart';

const _sectionLabelHorizontalPadding = 14.0;
const _sectionLabelVerticalPadding = 6.0;
const _sectionLabelLetterSpacing = 0.7;
const _destinationSpacing = 2.0;
const _minimumDestinationTargetHeight = 48.0;

/// Fortal-themed preset for [RemixSidebar].
///
/// The recipe paints the solid panel surface with a trailing edge border,
/// pads the scrolling destination region, keeps section labels compact and
/// muted, separates sections with Fortal's `space3` token, and reuses the
/// ghost `size2` toggle treatment inside full-width destinations with a
/// 48-logical-pixel minimum height. The footer carries the divider that
/// separates account content from navigation. [highContrast] strengthens
/// section and selected destination content without changing layout.
/// [panelPadding] applies host-owned insets inside the painted panel surface.
///
/// The recipe sets no panel width and no header padding. The host can supply
/// expanded/collapsed widths to the widget for coordinated animation, or size
/// the panel itself. Header metrics usually match an application top bar.
@MixWidget(target: RemixSidebar.new)
SidebarStyler fortalSidebarStyle({
  bool highContrast = false,
  bool collapsed = false,
  EdgeInsetsGeometry? panelPadding,
  SidebarStyler style = const SidebarStyler.create(),
}) {
  final horizontalPadding = Prop.mix(_SidebarHorizontalPadding(collapsed));
  return SidebarStyler(
    container:
        FlexBoxStyler(padding: EdgeInsetsGeometryMix.maybeValue(panelPadding))
            .color(FortalTokens.colorPanelSolid())
            .border(
              .end(
                .color(
                  FortalTokens.grayA5(),
                ).width(FortalTokens.borderWidth1()),
              ),
            ),
    content: FlexBoxStyler()
        .spacing(FortalTokens.space3())
        .padding(
          EdgeInsetsMix.create(
            left: horizontalPadding,
            right: horizontalPadding,
            top: Prop.token(FortalTokens.space4),
            bottom: Prop.token(FortalTokens.space4),
          ),
        ),
    footer: BoxStyler().border(
      .top(.color(FortalTokens.gray6()).width(FortalTokens.borderWidth1())),
    ),
    sectionLabel: fortalTextStyle(size: .size1, weight: .medium)
        .color(highContrast ? FortalTokens.gray12() : FortalTokens.gray11())
        .uppercase()
        .letterSpacing(_sectionLabelLetterSpacing)
        .wrap(
          .padding(
            .symmetric(
              horizontal: _sectionLabelHorizontalPadding,
              vertical: _sectionLabelVerticalPadding,
            ),
          ),
        ),
    tooltip: fortalTooltipStyle(),
    destinations: FlexBoxStyler().spacing(_destinationSpacing),
    destination:
        fortalToggleStyle(
              variant: .ghost,
              size: .size2,
              highContrast: highContrast,
            )
            .minHeight(_minimumDestinationTargetHeight)
            .padding(
              EdgeInsetsMix.create(
                left: Prop.mix(
                  _DestinationInlinePadding(collapsed, left: true),
                ),
                right: Prop.mix(
                  _DestinationInlinePadding(collapsed, left: false),
                ),
              ),
            )
            .container(.mainAxisSize(.max).mainAxisAlignment(.start)),
  ).merge(style);
}

/// Repays the narrowing panel inset on the leading side so icons hold still.
///
/// Icons stay `space3 + space4` from the panel's leading edge: expanded rows
/// start at `space4`, and the rail's narrower inset is added back here. A 72px
/// dashboard rail then settles each icon on its center line. The trailing side
/// keeps the toggle's `space3`. Sides are physical so this merges with the
/// toggle's own horizontal padding; the text direction picks the leading one.
final class _DestinationInlinePadding extends Mix<double> {
  const _DestinationInlinePadding(this.collapsed, {required this.left});
  final bool collapsed;
  final bool left;

  @override
  double resolve(BuildContext context) {
    final trailing = FortalTokens.space3.resolve(context);
    final leading = (Directionality.of(context) == TextDirection.ltr) == left;
    if (!leading) return trailing;
    return trailing +
        FortalTokens.space4.resolve(context) -
        _SidebarHorizontalPadding(collapsed).resolve(context);
  }

  @override
  Mix<double> merge(Mix<double>? other) => other ?? this;

  @override
  List<Object?> get props => [collapsed, left];
}

/// Resolve both endpoints before interpolation so theme scaling stays live.
final class _SidebarHorizontalPadding extends Mix<double> {
  const _SidebarHorizontalPadding(this.collapsed);
  final bool collapsed;

  @override
  double resolve(BuildContext context) {
    final expansion =
        RemixSidebar.maybeAnimationOf(context)?.expansion ??
        (collapsed ? 0.0 : 1.0);
    final rail = FortalTokens.space2.resolve(context);
    final expanded = FortalTokens.space3.resolve(context);
    return rail + (expanded - rail) * expansion;
  }

  @override
  Mix<double> merge(Mix<double>? other) => other ?? this;

  @override
  List<Object?> get props => [collapsed];
}
