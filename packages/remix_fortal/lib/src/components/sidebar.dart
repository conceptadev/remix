import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/theme.dart';
import 'text.dart';
import 'toggle.dart';

part 'sidebar.g.dart';

const _sectionLabelHorizontalPadding = 10.0;
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
/// The recipe sets no panel width and no header padding. Width belongs to the
/// host, which must also size any drawer that presents the same panel, and
/// header metrics usually have to match an application top bar.
@MixWidget(target: RemixSidebar.new)
SidebarStyler fortalSidebarStyle({
  bool highContrast = false,
  EdgeInsetsGeometry? panelPadding,
  SidebarStyler style = const SidebarStyler.create(),
}) {
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
          .symmetric(
            horizontal: FortalTokens.space3(),
            vertical: FortalTokens.space4(),
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
    destinations: FlexBoxStyler().spacing(_destinationSpacing),
    destination:
        fortalToggleStyle(
              variant: .ghost,
              size: .size2,
              highContrast: highContrast,
            )
            .minHeight(_minimumDestinationTargetHeight)
            .container(.mainAxisSize(.max).mainAxisAlignment(.start)),
  ).merge(style);
}
