import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../models/statuses.dart';
import '../style/defaults.dart';

/// Gap from the body to the completion row.
const _kChromeOffset = 12.0;

/// Copy / retry / feedback gutters.
const _kActionGap = 2.0;

/// Sources trigger inner gap.
const _kSourcesGap = 8.0;

/// Sources trigger horizontal inset.
const _kSourcesPad = 6.0;

/// Expanded sources well offset and pad.
const _kSourcesWellPad = 8.0;

/// Copy / retry / feedback glyph floor.
const _kActionIconSize = 14.0;

const _kEaseOut = Cubic(0.16, 1, 0.3, 1);
const _kChromeMs = 220;
const _kChromeReduceMs = 120;
const _kWellOpenMs = 220;
const _kWellCloseMs = 140;
const _kMotionShift = 4.0;
const _kWashMs = 150;

/// Streaming answer surface.
///
/// [child] is host-rendered. Copy, retry, sources, and [sourcesContent]
/// appear when [status] is complete or error, unless [showActions] overrides
/// that. [feedback] paints only when [status] is complete.
class AgentAnswer extends StatelessWidget {
  /// Creates an answer surface.
  const AgentAnswer({
    super.key,
    required this.child,
    this.status = AgentAnswerStatus.streaming,
    this.copyAction,
    this.retryAction,
    this.feedback,
    this.sources,
    this.sourcesContent,
    this.style,
    this.announce = true,
    this.showActions,
  });

  /// Host-rendered answer body.
  final Widget child;

  /// Current phase.
  final AgentAnswerStatus status;

  /// Optional copy control. Shown only after the stream settles.
  final Widget? copyAction;

  /// Optional retry control. Shown only after the stream settles.
  final Widget? retryAction;

  /// Optional feedback controls. Shown only when [status] is complete.
  final Widget? feedback;

  /// Optional sources trigger. Shown in the completion row after settle.
  final Widget? sources;

  /// Optional expanded sources. Shown in a muted well under the row.
  final Widget? sourcesContent;

  /// Optional card style. Off by default — an answer is prose.
  final CardStyler? style;

  /// When true, marks the region as live while streaming.
  final bool announce;

  /// Host override. Null follows [AgentAnswerStatusX.showsActions].
  final bool? showActions;

  @override
  Widget build(BuildContext context) {
    final reveal = showActions ?? status.showsActions;
    final includeFeedback =
        feedback != null && status == AgentAnswerStatus.complete;
    final includeRow =
        copyAction != null ||
        retryAction != null ||
        includeFeedback ||
        sources != null;
    final includeWell = sourcesContent != null;
    final ink = agentInkOf(context);

    final content = ColumnBox(
      style: FlexBoxStyler().crossAxisAlignment(.stretch).mainAxisSize(.min),
      children: [
        DefaultTextStyle.merge(
          style: agentConversationOf(
            context,
          ).copyWith(color: ink.withValues(alpha: 0.90)),
          child: child,
        ),
        _AnswerChromeReveal(
          visible: reveal && (includeRow || includeWell),
          child: ColumnBox(
            style: FlexBoxStyler()
                .crossAxisAlignment(.stretch)
                .mainAxisSize(.min)
                .padding(.only(top: _kChromeOffset)),
            children: [
              if (includeRow)
                RowBox(
                  key: const ValueKey('agent-answer-actions'),
                  style: FlexBoxStyler()
                      .crossAxisAlignment(.center)
                      .mainAxisSize(.min)
                      .spacing(_kActionGap),
                  children: [
                    if (copyAction != null)
                      _AnswerChrome(
                        slotKey: const ValueKey('agent-answer-copy'),
                        tight: true,
                        pressScale: true,
                        child: copyAction!,
                      ),
                    if (retryAction != null)
                      _AnswerChrome(
                        slotKey: const ValueKey('agent-answer-retry'),
                        tight: true,
                        pressScale: true,
                        child: retryAction!,
                      ),
                    if (includeFeedback)
                      _AnswerChrome(
                        slotKey: const ValueKey('agent-answer-feedback'),
                        pressScale: true,
                        child: feedback!,
                      ),
                    if (sources != null)
                      _AnswerChrome(
                        slotKey: const ValueKey('agent-answer-sources'),
                        pad: _kSourcesPad,
                        child: RowBox(
                          style: FlexBoxStyler()
                              .mainAxisSize(.min)
                              .crossAxisAlignment(.center)
                              .spacing(_kSourcesGap),
                          children: [sources!],
                        ),
                      ),
                  ],
                ),
              _AnswerWellReveal(
                open: reveal && includeWell,
                child: includeWell
                    ? Padding(
                        padding: const EdgeInsets.only(top: _kSourcesWellPad),
                        child: Box(
                          key: const ValueKey('agent-answer-sources-well'),
                          style: BoxStyler()
                              .padding(.all(_kSourcesWellPad))
                              .borderRadius(.circular(kAgentControlRadius))
                              .color(ink.withValues(alpha: 0.06)),
                          child: DefaultTextStyle.merge(
                            style: agentMetaOf(context),
                            child: sourcesContent!,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ],
    );

    return Semantics(
      container: true,
      liveRegion: announce && status.isStreaming,
      label: status.isStreaming ? 'Streaming answer' : 'Answer',
      child: agentMaybeCard(context: context, style: style, child: content),
    );
  }
}

/// 28-floor muted 6px-radius hover-wash. [tight] pins a 28×28 icon slot.
/// [pressScale] is the 0.9 spring; skipped when reduced motion.
class _AnswerChrome extends StatelessWidget {
  const _AnswerChrome({
    required this.slotKey,
    required this.child,
    this.tight = false,
    this.pressScale = false,
    this.pad,
  });

  final Key slotKey;
  final Widget child;
  final bool tight;
  final bool pressScale;
  final double? pad;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      mouseCursor: MouseCursor.defer,
      includeFocusSemantics: false,
      child: _AnswerChromeSlot(
        key: slotKey,
        tight: tight,
        pressScale: pressScale,
        pad: pad,
        child: child,
      ),
    );
  }
}

class _AnswerChromeSlot extends StatefulWidget {
  const _AnswerChromeSlot({
    super.key,
    required this.child,
    required this.tight,
    required this.pressScale,
    this.pad,
  });

  final Widget child;
  final bool tight;
  final bool pressScale;
  final double? pad;

  @override
  State<_AnswerChromeSlot> createState() => _AnswerChromeSlotState();
}

class _AnswerChromeSlotState extends State<_AnswerChromeSlot> {
  final _states = WidgetStatesController();
  FocusNode? _ancestor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final node = Focus.maybeOf(context);
    if (!identical(node, _ancestor)) {
      _ancestor?.removeListener(_syncFocus);
      _ancestor = node;
      _ancestor?.addListener(_syncFocus);
    }
    _syncFocus();
  }

  @override
  void dispose() {
    _ancestor?.removeListener(_syncFocus);
    _states.dispose();
    super.dispose();
  }

  void _syncFocus() {
    _states.focused = _ancestor?.hasFocus ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final ink = agentInkOf(context);
    final reduce = MediaQuery.disableAnimationsOf(context);
    var chrome = BoxStyler()
        .minWidth(kAgentActionSize)
        .minHeight(kAgentActionSize)
        .borderRadius(.circular(kAgentActionRadius))
        .color(const Color(0x00000000))
        .onHovered(.color(ink.withValues(alpha: 0.06)))
        .animate(reduce ? .linear(Duration.zero) : .easeOut(_kWashMs.ms));
    if (widget.tight) {
      chrome = chrome
          .size(kAgentActionSize, kAgentActionSize)
          .alignment(.center);
    } else if (widget.pad != null) {
      chrome = chrome.padding(.horizontal(widget.pad!));
    }

    // Keep the inset ring off the wash styler. Sharing .animate() with the
    // 6% hover ease interpolates the stroke away on the first frames.
    return PressableBox(
      controller: _states,
      canRequestFocus: false,
      excludeFromSemantics: true,
      semanticsRole: PressableSemanticsRole.none,
      mouseCursor: MouseCursor.defer,
      style: BoxStyler()
          .borderRadius(.circular(kAgentActionRadius))
          .onFocusVisible(
            .foregroundDecoration(
              .border(
                .color(ink)
                    .width(kAgentFocusRingWidth)
                    .strokeAlign(BorderSide.strokeAlignInside),
              ).borderRadius(.circular(kAgentActionRadius)),
            ),
          ),
      child: Box(
        style: chrome,
        child: ListenableBuilder(
          listenable: _states,
          builder: (context, _) {
            final hovered = _states.value.contains(WidgetState.hovered);
            final color = hovered ? ink : agentMutedOf(context);
            Widget slot = DefaultTextStyle.merge(
              style: agentMetaOf(context).copyWith(color: color),
              child: IconTheme(
                data: IconThemeData(size: _kActionIconSize, color: color),
                child: widget.child,
              ),
            );
            if (!widget.tight) {
              slot = SizedBox(
                height: kAgentActionSize,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [slot],
                ),
              );
            }
            if (!widget.pressScale || reduce) {
              return slot;
            }
            return Box(
              style: BoxStyler()
                  .onPressed(.scale(0.9))
                  .animate(
                    AnimationConfig.springDescription(
                      mass: 0.6,
                      stiffness: 500,
                      damping: 30,
                    ),
                  ),
              child: slot,
            );
          },
        ),
      ),
    );
  }
}

/// Fade + 4px rise when the completion chrome mounts. Exit is opacity only.
class _AnswerChromeReveal extends StatelessWidget {
  const _AnswerChromeReveal({required this.visible, required this.child});

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final tEnd = visible ? 1.0 : 0.0;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: tEnd, end: tEnd),
      duration: Duration(milliseconds: reduce ? _kChromeReduceMs : _kChromeMs),
      curve: _kEaseOut,
      builder: (context, t, child) {
        if (t <= 0 && !visible) {
          return const SizedBox.shrink();
        }
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, visible && !reduce ? (1 - t) * _kMotionShift : 0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

/// Clip + opacity + 4px y. Snaps when reduced motion.
class _AnswerWellReveal extends StatefulWidget {
  const _AnswerWellReveal({required this.open, this.child});

  final bool open;
  final Widget? child;

  @override
  State<_AnswerWellReveal> createState() => _AnswerWellRevealState();
}

class _AnswerWellRevealState extends State<_AnswerWellReveal> {
  Widget? _held;

  @override
  void initState() {
    super.initState();
    _held = widget.child;
  }

  @override
  void didUpdateWidget(_AnswerWellReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != null) {
      _held = widget.child;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final tEnd = widget.open ? 1.0 : 0.0;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: tEnd, end: tEnd),
      duration: reduce
          ? Duration.zero
          : Duration(milliseconds: widget.open ? _kWellOpenMs : _kWellCloseMs),
      curve: _kEaseOut,
      builder: (context, t, child) {
        if (t <= 0 && !widget.open) {
          return const SizedBox.shrink();
        }
        final content = child ?? _held;
        if (content == null) {
          return const SizedBox.shrink();
        }
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: t,
            child: Opacity(
              opacity: t,
              child: Transform.translate(
                offset: Offset(0, reduce ? 0 : (1 - t) * -_kMotionShift),
                child: content,
              ),
            ),
          ),
        );
      },
      child: widget.child ?? _held,
    );
  }
}
