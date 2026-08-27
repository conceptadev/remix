import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'link.g.dart';

/// The application's Link recipe.
///
/// Remix owns the link role, the destination, focus, activation, and the rule
/// that a link with no callback is a disabled link; this recipe supplies only
/// its color and its underline.
///
/// It sets no font size on purpose. A link is inline text, so it should take
/// the size and weight of the paragraph around it — a fixed size here would
/// make a link inside a heading render at body scale.
///
/// The color is `foreground`, not `primary`. This theme's `primary` is a
/// near-neutral fill color rather than a link hue, so a `primary` link would
/// read as body text with no affordance at all. Underlining is what marks it,
/// which also means the link is still identifiable without color — an
/// application that has a brand link color changes the two `.color(...)` calls
/// below.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's hover color has to be
/// declared as a hover fragment too (`LinkStyler().onHovered(...)`).
@MixWidget(name: 'PlaygroundLink', target: RemixLink.new)
LinkStyler playgroundLinkStyle({
  LinkStyler style = const LinkStyler.create(),
}) => LinkStyler()
    .label(
      .color(PlaygroundTokens.foreground())
          .decoration(TextDecoration.underline)
          .decorationColor(PlaygroundTokens.border()),
    )
    // Hover and keyboard focus both promote the underline to full strength
    // rather than adding one: an underline that appears on hover moves the
    // text's baseline box on some platforms, and a link that is only
    // underlined while hovered is invisible to a keyboard user.
    .onHovered(_emphasized())
    .onFocusVisible(_emphasized())
    .onDisabled(_disabledStyle())
    .merge(style);

/// Opacity applied to the whole link while disabled.
const _disabledOpacity = 0.5;

/// The underline at full strength, in the text's own color.
LinkStyler _emphasized() =>
    LinkStyler().label(.decorationColor(PlaygroundTokens.foreground()));

/// Declared last so it wins over every other state fragment.
///
/// A link with no `onPressed` is disabled by Remix, which is the same meaning
/// `onPressed: null` carries on every other Flutter control, so this fragment
/// is also what a decorative link looks like.
LinkStyler _disabledStyle() =>
    LinkStyler().wrap(WidgetModifierConfig.opacity(_disabledOpacity));
