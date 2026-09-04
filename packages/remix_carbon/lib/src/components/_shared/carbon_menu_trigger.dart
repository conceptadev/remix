import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';

/// Builds a Remix menu trigger with Carbon's trailing-icon anatomy.
///
/// The custom content stays non-interactive so [RemixMenu] remains the single
/// owner of focus, keyboard activation, semantics, and overlay state.
RemixMenuTrigger carbonMenuTriggerWithTrailingIcon({
  required String label,
  required IconData trailingIcon,
  required IconStyler iconStyle,
}) => .builder(
  label: label,
  builder: (context, _, child) => Stack(
    children: [
      child!,
      PositionedDirectional(
        top: 0,
        bottom: 0,
        end: CarbonTokens.spacing05.resolve(context),
        child: Center(
          child: IgnorePointer(
            child: ExcludeSemantics(
              child: StyledIcon(icon: trailingIcon, style: iconStyle),
            ),
          ),
        ),
      ),
    ],
  ),
);
