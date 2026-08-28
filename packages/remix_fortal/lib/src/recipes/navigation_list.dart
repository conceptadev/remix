import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../fortal/fortal.dart';
import 'text.dart';
import 'toggle.dart';

part 'navigation_list.g.dart';

const _sectionLabelHorizontalPadding = 10.0;
const _sectionLabelVerticalPadding = 6.0;
const _sectionLabelLetterSpacing = 0.7;
const _destinationSpacing = 2.0;
const _minimumDestinationTargetHeight = 48.0;

/// Fortal-themed preset for [RemixNavigationList].
///
/// The recipe keeps section labels compact and muted, separates sections with
/// Fortal's `space3` token, and reuses the ghost `size2` toggle treatment inside
/// full-width destinations with a 48-logical-pixel minimum height. [highContrast]
/// strengthens section and selected destination content without changing
/// layout.
@MixWidget(target: RemixNavigationList.new)
NavigationListStyler fortalNavigationListStyle({bool highContrast = false}) {
  return NavigationListStyler(
    container: FlexBoxStyler().spacing(FortalTokens.space3()),
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
  );
}
