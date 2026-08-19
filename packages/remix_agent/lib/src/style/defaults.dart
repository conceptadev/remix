import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

/// Outer surface corner. Composer, permission, and user bubbles.
const kAgentSurfaceRadius = 16.0;

/// Inner well and control corner.
const kAgentControlRadius = 12.0;

/// Composer instrument inset.
const kAgentComposerPad = 8.0;

/// Composer toolbar floor and send/stop control.
const kAgentComposerControlSize = 32.0;

/// Answer copy/retry slot, sources trigger, and message expand pill.
const kAgentActionSize = 28.0;

/// Compact icon-action corner. Answer slots and sources trigger.
const kAgentActionRadius = 6.0;

/// Field top inset inside [kAgentComposerPad]. Horizontal uses the card pad.
const kAgentComposerFieldPadTop = 6.0;

/// Permission body inset.
const kAgentPermissionPad = 16.0;

/// Parameter label max track. `7rem` at the 16px host root.
const kAgentParameterLabelWidth = 112.0;

/// Permission header status well.
const kAgentPermissionWellSize = 32.0;

/// Plan and execution trigger floor. Activity and plan item rows share this.
const kAgentRowMinHeight = 36.0;

/// Plan item list viewport cap.
const kAgentPlanViewportHeight = 248.0;

/// Activity ledger viewport. Working runs fill this well.
const kAgentActivityViewportHeight = 208.0;

/// User bubble floor.
const kAgentUserBubbleMinWidth = 36.0;

/// Reserved end gutter so transcript line width does not jump on overflow.
const kAgentScrollbarGutter = 12.0;

/// Inset focus-visible ring on the transcript viewport.
const kAgentFocusRingWidth = 2.0;

/// Ink taken from the host [DefaultTextStyle], not a shipped palette.
Color agentInkOf(BuildContext context) {
  return DefaultTextStyle.of(context).style.color ?? const Color(0xFF18181B);
}

/// Secondary copy: same ink, reduced contrast.
Color agentMutedOf(BuildContext context) {
  return agentInkOf(context).withValues(alpha: 0.62);
}

/// Completed list titles. Quieter than [agentMutedOf].
Color agentCompletedOf(BuildContext context) {
  return agentInkOf(context).withValues(alpha: 0.45);
}

Color _onInk(Color ink) {
  return ink.computeLuminance() > 0.45
      ? const Color(0xFF111111)
      : const Color(0xFFFFFFFF);
}

Color _dangerOf(Color ink) {
  return ink.computeLuminance() > 0.45
      ? const Color(0xFFB42318)
      : const Color(0xFFF97066);
}

TextStyle _baseOf(BuildContext context) => DefaultTextStyle.of(context).style;

/// Title run: 15 / semibold.
TextStyle agentTitleOf(BuildContext context) {
  return _baseOf(context).copyWith(
    fontSize: 15,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: agentInkOf(context),
  );
}

/// Body run: 14 / regular.
TextStyle agentBodyOf(BuildContext context) {
  return _baseOf(context).copyWith(
    fontSize: 14,
    height: 1.45,
    fontWeight: FontWeight.w400,
    color: agentInkOf(context),
  );
}

/// Conversation run: 14 / 24.
TextStyle agentConversationOf(BuildContext context) {
  return _baseOf(context).copyWith(
    fontSize: 14,
    height: 24 / 14,
    fontWeight: FontWeight.w400,
    color: agentInkOf(context),
  );
}

/// Meta run: 12 / muted / tabular. Counts stay the same width for 1/10 and 9/10.
TextStyle agentMetaOf(BuildContext context) {
  return _baseOf(context).copyWith(
    fontSize: 12,
    height: 1.35,
    fontWeight: FontWeight.w400,
    fontFeatures: const [FontFeature.tabularFigures()],
    color: agentMutedOf(context),
  );
}

/// Completed list title. Quieter than a live row.
TextStyle agentCompletedOfStyle(BuildContext context) {
  return agentBodyOf(context).copyWith(color: agentCompletedOf(context));
}

CardStyler agentCardStyle(BuildContext context) {
  final ink = agentInkOf(context);
  return CardStyler()
      .color(ink.withValues(alpha: 0.06))
      .padding(.all(12))
      .borderRadius(.circular(kAgentSurfaceRadius))
      .border(.all(.color(ink.withValues(alpha: 0.16)).width(1)));
}

/// Soft user bubble. Fill only — do not inherit [agentCardStyle]'s stroke.
CardStyler agentUserCardStyle(BuildContext context) {
  final ink = agentInkOf(context);
  return CardStyler()
      .color(ink.withValues(alpha: 0.10))
      .padding(.only(left: 14, right: 14, top: 10, bottom: 10))
      .borderRadius(.circular(kAgentSurfaceRadius))
      .minWidth(kAgentUserBubbleMinWidth);
}

/// Permission surface. Body applies [kAgentPermissionPad]; the card itself
/// has no pad so the action footer can sit on a hairline. Clip to the 16px
/// radius so the status well and footer hairline stay on the surface.
CardStyler agentPermissionStyle(BuildContext context) {
  return agentCardStyle(context).padding(.all(0)).clipBehavior(Clip.antiAlias);
}

/// Outer surface for [AgentComposer]. Host background; [focused]
/// strengthens the border only. Border color eases; reduced motion snaps.
CardStyler agentComposerStyle(BuildContext context, {bool focused = false}) {
  final ink = agentInkOf(context);
  final reduce = MediaQuery.disableAnimationsOf(context);
  return CardStyler()
      .padding(.all(kAgentComposerPad))
      .borderRadius(.circular(kAgentSurfaceRadius))
      .border(
        .all(.color(ink.withValues(alpha: focused ? 0.25 : 0.16)).width(1)),
      )
      .animate(reduce ? .linear(Duration.zero) : .ease(150.ms));
}

/// 32×32 circular send/stop chrome. [iconSize] is 16 for send, 12 for stop.
/// Empty/disabled send is the control at 50% opacity, not a washed fill.
IconButtonStyler agentComposerActionStyle(
  BuildContext context, {
  double iconSize = 16,
}) {
  final ink = agentInkOf(context);
  return IconButtonStyler()
      .size(kAgentComposerControlSize, kAgentComposerControlSize)
      .alignment(Alignment.center)
      .color(ink)
      .iconColor(_onInk(ink))
      .iconSize(iconSize)
      .borderRadius(.circular(kAgentComposerControlSize / 2))
      .onHovered(IconButtonStyler().color(ink.withValues(alpha: 0.82)))
      .onDisabled(IconButtonStyler().wrap(.opacity(0.5)));
}

ButtonStyler agentButtonStyle(BuildContext context) {
  final ink = agentInkOf(context);
  return ButtonStyler()
      .color(ink)
      .labelColor(_onInk(ink))
      .padding(.horizontal(12))
      .padding(.vertical(8))
      .borderRadius(.circular(kAgentControlRadius))
      .onHovered(ButtonStyler().color(ink.withValues(alpha: 0.82)));
}

ButtonStyler agentQuietButtonStyle(BuildContext context) {
  final ink = agentInkOf(context);
  return ButtonStyler()
      .color(const Color(0x00000000))
      .labelColor(ink)
      .padding(.horizontal(12))
      .padding(.vertical(8))
      .borderRadius(.circular(kAgentControlRadius))
      .border(.all(.color(ink.withValues(alpha: 0.16)).width(1)))
      .onHovered(ButtonStyler().color(ink.withValues(alpha: 0.06)));
}

ButtonStyler agentDangerButtonStyle(BuildContext context) {
  final ink = agentInkOf(context);
  return ButtonStyler()
      .color(const Color(0x00000000))
      .labelColor(_dangerOf(ink))
      .padding(.horizontal(12))
      .padding(.vertical(8))
      .borderRadius(.circular(kAgentControlRadius))
      .onHovered(ButtonStyler().color(_dangerOf(ink).withValues(alpha: 0.08)));
}

TextStyler get _hitlLabel =>
    TextStyler().fontSize(12).fontWeight(FontWeight.w500);

ButtonStyler _withPressScale(BuildContext context, ButtonStyler style) {
  if (MediaQuery.disableAnimationsOf(context)) {
    return style;
  }
  return style
      .onPressed(.scale(0.97))
      .animate(
        AnimationConfig.springDescription(
          mass: 0.6,
          stiffness: 500,
          damping: 30,
        ),
      );
}

/// Filled pending action (Allow once).
ButtonStyler agentAllowButtonStyle(BuildContext context) {
  return _withPressScale(
    context,
    agentButtonStyle(
      context,
    ).padding(.horizontal(12)).padding(.vertical(6)).label(_hitlLabel),
  );
}

/// Paper-filled outlined pending action (Always allow).
ButtonStyler agentAlwaysButtonStyle(BuildContext context) {
  final ink = agentInkOf(context);
  final paper = _onInk(ink);
  return _withPressScale(
    context,
    agentQuietButtonStyle(context)
        .color(paper)
        .onHovered(
          ButtonStyler().color(
            Color.alphaBlend(ink.withValues(alpha: 0.06), paper),
          ),
        )
        .padding(.horizontal(12))
        .padding(.vertical(6))
        .label(_hitlLabel),
  );
}

/// Ghost pending action (Deny). Hover lifts the muted label to ink.
ButtonStyler agentDenyButtonStyle(BuildContext context) {
  final ink = agentInkOf(context);
  return ButtonStyler()
      .color(const Color(0x00000000))
      .labelColor(agentMutedOf(context))
      .label(_hitlLabel)
      .padding(.horizontal(12))
      .padding(.vertical(6))
      .borderRadius(.circular(kAgentControlRadius))
      .onHovered(
        ButtonStyler()
            .color(ink.withValues(alpha: 0.06))
            .label(TextStyler().color(ink)),
      );
}

/// Borderless field. The composer card is the instrument chrome.
/// Placeholder keeps the 14/24 run and only drops contrast.
TextFieldStyler agentComposerFieldStyle(BuildContext context) {
  final ink = agentInkOf(context);
  final run = agentConversationOf(context);
  final runStyle = TextStyler().fontSize(run.fontSize!).height(run.height!);
  return TextFieldStyler()
      .color(const Color(0x00000000))
      .padding(
        .only(
          left: kAgentComposerPad,
          right: kAgentComposerPad,
          top: kAgentComposerFieldPadTop,
        ),
      )
      .text(runStyle.color(ink))
      .hintText(runStyle.color(ink.withValues(alpha: 0.55)))
      .cursorColor(ink);
}

/// Inset well for tool arguments. Paper fill on the 6% card; stroke is
/// slightly stronger than the card hairline so the well reads as inset.
BoxStyler agentWellStyle(BuildContext context) {
  final ink = agentInkOf(context);
  final paper = ink.computeLuminance() > 0.45
      ? const Color(0xFF111111)
      : const Color(0xFFFFFFFF);
  return BoxStyler()
      .color(paper)
      .padding(.all(12))
      .borderRadius(.circular(kAgentControlRadius))
      .border(.all(.color(ink.withValues(alpha: 0.20)).width(1)));
}

/// Optional card wrap so hosts can restore a surface.
Widget agentMaybeCard({
  required BuildContext context,
  required Widget child,
  CardStyler? style,
}) {
  if (style == null) {
    return child;
  }
  return RemixCard(style: style, child: child);
}
