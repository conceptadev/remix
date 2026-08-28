import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'disclosure.g.dart';

/// The application's Disclosure recipe.
///
/// A single collapsible section: a trigger row and the content it reveals.
/// Remix owns the rendering, the expand and collapse animation, keyboard
/// activation, and the accessibility semantics — including announcing the
/// expanded state; this recipe supplies the trigger row, the content inset,
/// and the state fragments.
///
/// It is deliberately frameless, unlike the card. The accordion is this
/// component's stacked sibling and draws a rule under each section because
/// its rows have neighbours to separate; a lone disclosure has none, so a
/// frame would only box in whatever the caller already placed it inside.
/// The trigger is styled as a self-contained row target instead — same
/// padding, radius, and hover treatment as a menu row, because behaviorally
/// that is what it is: a full-width thing you click.
///
/// The spec carries plain boxes (`trigger`, `content`), not text: the caller
/// passes whole widgets for both, so their type belongs to the caller. The
/// hover and open fills are `accent` and `muted`, which in the shipped themes
/// are near-surface tints the `foreground` text keeps its contrast on.
///
/// Two constructor parameters are deliberately not forwarded to the generated
/// `PlaygroundDisclosure`: `triggerBuilder` and `transitionBuilder`. Both
/// are typed by `package:naked_ui`, which this layer does not depend on.
/// Reach for `RemixDisclosure` directly on the rare call site that needs a
/// state-aware trigger or a custom transition.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state,
/// not by depth: an override that must beat the open trigger's fill has to be
/// declared with `.onExpanded(...)` too.
@MixWidget(
  target: RemixDisclosure.new,
  widgetParameters: .only({
    'trigger',
    'content',
    'expanded',
    'defaultExpanded',
    'onExpandedChanged',
    'enabled',
    'mouseCursor',
    'enableFeedback',
    'focusNode',
    'autofocus',
    'onFocusChange',
    'onHoverChange',
    'onPressChange',
    'semanticLabel',
    'semanticHint',
    'excludeSemantics',
    'animationStyle',
  }),
)
DisclosureStyler playgroundDisclosureStyle({
  DisclosureStyler style = const DisclosureStyler.create(),
}) => DisclosureStyler()
    // These are the forwarded box shorthand, so they land on `trigger`: the
    // row a reader clicks to open the section.
    .width(double.infinity)
    .alignment(.centerLeft)
    .minHeight(_triggerHeight)
    .padding(.symmetric(horizontal: _paddingX, vertical: _paddingY))
    .borderRadius(.all(PlaygroundTokens.radius()))
    // `content` has to be reached by name; a bare `.padding(...)` would inset
    // the trigger instead. The horizontal inset matches the trigger's so the
    // revealed content lines up under the trigger's own.
    .content(
      .padding(
        .only(
          left: _paddingX,
          right: _paddingX,
          top: _contentGap,
          bottom: _contentGap,
        ),
      ),
    )
    .onHovered(DisclosureStyler().color(PlaygroundTokens.accent()))
    // The open trigger keeps a fill after the pointer leaves, so a reader
    // scanning the page can tell an open section from a closed one without
    // touching it. `muted` rather than `accent`: the two must differ, or
    // hovering a closed section would look identical to one that is open.
    .onExpanded(DisclosureStyler().color(PlaygroundTokens.muted()))
    .onFocusVisible(_focusVisibleStyle())
    .onDisabled(_disabledStyle())
    .merge(style);

/// Minimum height of the trigger row.
///
/// The accordion's 44px, not the menu row's 32: this row stands alone on the
/// page rather than inside a dense list, so it keeps the full touch target.
const _triggerHeight = 44.0;

/// Horizontal inset inside the trigger, matched by the content.
const _paddingX = 12.0;

/// Vertical inset inside the trigger.
const _paddingY = 10.0;

/// Inset above and below the revealed content.
///
/// Both sides, not just the top. Without the bottom the last line of content
/// sits hard against the container's own edge, which is invisible while the
/// container is undecorated and obvious the moment it is not — the focus ring
/// is drawn there, and a consumer who gives the container a fill or a border
/// gets text touching it.
const _contentGap = 8.0;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Opacity applied to the whole section while disabled.
const _disabledOpacity = 0.5;

/// The keyboard focus ring, drawn on the trigger alone.
///
/// Not on the container, which is where the effects layer lives and where the
/// accordion puts its ring. Keyboard focus is on the trigger, and an expanded
/// disclosure's container is the trigger *plus* everything it revealed — a
/// ring there claims the content is focused too, and grows with it.
///
/// `foregroundDecoration` is what makes a trigger-only ring possible: it
/// paints over the box's own bounds rather than beside them, so the ring
/// takes no layout space and opening the section never reflows the page. A
/// plain `.border(...)` would push the trigger's content in by two pixels the
/// moment it took focus.
DisclosureStyler _focusVisibleStyle() => DisclosureStyler().trigger(
  .foregroundDecoration(
    BoxDecorationMix.border(
      .color(PlaygroundTokens.focusRing()).width(_focusRingWidth),
    ).borderRadius(.all(PlaygroundTokens.radius())),
  ),
);

/// Declared last so it wins over every other state fragment.
///
/// The ring is cleared as well as faded: a disabled control that still draws
/// a focus ring reads as reachable.
DisclosureStyler _disabledStyle() => DisclosureStyler()
    .trigger(.foregroundDecoration(BoxDecorationMix.border(.style(.none))))
    .wrap(.opacity(_disabledOpacity));
