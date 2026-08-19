import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../models/statuses.dart';
import '../style/defaults.dart';
import 'marks.dart';

/// Collapsed copy is four conversation lines (14 / 24).
const _kCollapsedLines = 4;

/// Opaque through 68%, then fade to transparent.
const _kFadeStop = 0.68;

/// Gutter from the clamped copy to the expand pill.
const _kMoreGutter = 8.0;

/// Horizontal pad inside the expand pill.
const _kMorePad = 8.0;

/// Label ↔ caret inside the expand pill.
const _kMoreCaretGap = 4.0;

/// Where a message row sits in the transcript.
enum AgentMessageAlign {
  /// Start of the row (assistant default).
  start,

  /// End of the row (user default).
  end,
}

/// Groups consecutive [AgentMessage] rows.
class AgentMessageGroup extends StatelessWidget {
  /// Creates a message group.
  const AgentMessageGroup({
    super.key,
    required this.children,
    this.spacing = 6,
  });

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: spacing,
      children: children,
    );
  }
}

/// Sender-aware transcript row.
class AgentMessage extends StatelessWidget {
  /// Creates a message row.
  const AgentMessage({
    super.key,
    required this.role,
    required this.child,
    this.align,
    this.avatar,
    this.showAvatar = false,
    this.placeholderAvatar = false,
    this.expand,
    this.maxWidth,
    this.header,
    this.footer,
    this.style,
  });

  /// Who authored the row.
  final AgentRole role;

  /// Body. Hosts supply rendered content.
  final Widget child;

  /// Optional align override. Defaults from [role].
  final AgentMessageAlign? align;

  /// Optional avatar. Never invented: no letter fallback.
  final Widget? avatar;

  /// When false, no avatar slot is reserved unless [placeholderAvatar].
  final bool showAvatar;

  /// Keep an empty avatar slot so grouped rows stay aligned.
  final bool placeholderAvatar;

  /// When true, the body fills the remaining row. Defaults to start-aligned.
  final bool? expand;

  /// Max width of a user bubble. Defaults to 82% of the row.
  final double? maxWidth;

  /// Optional metadata above the body.
  final Widget? header;

  /// Optional metadata below the body.
  final Widget? footer;

  /// Optional card style. Assistant has no card unless this is set.
  final CardStyler? style;

  bool get _alignEnd =>
      (align ??
          (role == AgentRole.user
              ? AgentMessageAlign.end
              : AgentMessageAlign.start)) ==
      AgentMessageAlign.end;

  bool get _expand => expand ?? !_alignEnd;

  @override
  Widget build(BuildContext context) {
    final prose = DefaultTextStyle.merge(
      style: agentConversationOf(context),
      child: _AgentMessageCopy(child: child),
    );

    final Widget bubble;
    if (_alignEnd) {
      bubble = RemixCard(
        style: style ?? agentUserCardStyle(context),
        child: prose,
      );
    } else if (style != null) {
      bubble = RemixCard(style: style!, child: prose);
    } else {
      bubble = prose;
    }

    final sized = _expand
        ? bubble
        : LayoutBuilder(
            builder: (context, constraints) {
              final cap =
                  maxWidth ??
                  (constraints.maxWidth.isFinite
                      ? constraints.maxWidth * 0.82
                      : 360);
              final max = cap < kAgentUserBubbleMinWidth
                  ? kAgentUserBubbleMinWidth
                  : cap;
              return Align(
                alignment: _alignEnd
                    ? AlignmentDirectional.centerEnd
                    : AlignmentDirectional.centerStart,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: kAgentUserBubbleMinWidth,
                    maxWidth: max,
                  ),
                  child: IntrinsicWidth(child: bubble),
                ),
              );
            },
          );

    final stack = Column(
      crossAxisAlignment: _alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) ...[header!, const SizedBox(height: 4)],
        sized,
        if (footer != null) ...[const SizedBox(height: 4), footer!],
      ],
    );

    final leading = _avatarSlot();

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: _alignEnd
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!_alignEnd && leading != null) ...[
          leading,
          const SizedBox(width: 8),
        ],
        Flexible(child: stack),
        if (_alignEnd && leading != null) ...[
          const SizedBox(width: 8),
          leading,
        ],
      ],
    );

    return Semantics(
      container: true,
      label: role == AgentRole.user ? 'User message' : 'Assistant message',
      child: row,
    );
  }

  Widget? _avatarSlot() {
    if (placeholderAvatar) {
      return const SizedBox(width: 32, height: 32);
    }
    if (!showAvatar) {
      return null;
    }
    return avatar;
  }
}

/// Long copy clamps to four lines with a bottom fade and an expand pill.
class _AgentMessageCopy extends StatefulWidget {
  const _AgentMessageCopy({required this.child});

  final Widget child;

  @override
  State<_AgentMessageCopy> createState() => _AgentMessageCopyState();
}

class _AgentMessageCopyState extends State<_AgentMessageCopy> {
  var _open = false;
  var _overflows = false;

  double _collapsedHeightOf(BuildContext context) {
    final run = DefaultTextStyle.of(context).style;
    final fontSize = run.fontSize ?? 14;
    final height = run.height ?? 24 / 14;
    return fontSize * height * _kCollapsedLines;
  }

  void _reportOverflow(bool overflows) {
    if (overflows == _overflows) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || overflows == _overflows) {
        return;
      }
      setState(() => _overflows = overflows);
    });
  }

  @override
  Widget build(BuildContext context) {
    final collapsedHeight = _collapsedHeightOf(context);
    final fade = !_open && _overflows;
    final copy = Box(
      key: const ValueKey('agent-message-copy'),
      style: fade
          ? BoxStyler().wrap(
              WidgetModifierConfig.shaderMask(
                shaderCallback: ShaderCallbackBuilder.linearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: const [
                    Color(0xFF000000),
                    Color(0xFF000000),
                    Color(0x00000000),
                  ],
                  stops: const [0, _kFadeStop, 1],
                ),
                blendMode: BlendMode.dstIn,
              ),
            )
          : BoxStyler(),
      child: _MessageClamp(
        maxHeight: collapsedHeight,
        clamp: !_open,
        onOverflow: _reportOverflow,
        child: widget.child,
      ),
    );

    return ColumnBox(
      style: FlexBoxStyler()
          .crossAxisAlignment(.start)
          .mainAxisSize(.min)
          .spacing(_overflows ? _kMoreGutter : 0),
      children: [
        copy,
        if (_overflows)
          RemixButton(
            key: const ValueKey('agent-message-more'),
            label: _open ? 'Show less' : 'Show more',
            onPressed: () => setState(() => _open = !_open),
            trailingIconBuilder: (_, _, _) => AgentChevron(expanded: _open),
            style: _messageMoreStyle(context),
          ),
      ],
    );
  }
}

ButtonStyler _messageMoreStyle(BuildContext context) {
  final ink = agentInkOf(context);
  return ButtonStyler()
      .height(kAgentActionSize)
      .padding(.horizontal(_kMorePad))
      .mainAxisSize(.min)
      .borderRadius(.circular(kAgentActionSize / 2))
      .color(const Color(0x00000000))
      .label(
        TextStyler()
            .fontSize(12)
            .fontWeight(FontWeight.w500)
            .color(agentMutedOf(context)),
      )
      .spacing(_kMoreCaretGap)
      .iconAlignment(.end)
      .wrap(
        WidgetModifierConfig.align(alignment: AlignmentDirectional.centerStart),
      )
      .onHovered(
        ButtonStyler()
            .color(ink.withValues(alpha: 0.06))
            .label(TextStyler().color(ink)),
      );
}

class _MessageClamp extends SingleChildRenderObjectWidget {
  const _MessageClamp({
    required this.maxHeight,
    required this.clamp,
    required this.onOverflow,
    required super.child,
  });

  final double maxHeight;
  final bool clamp;
  final ValueChanged<bool> onOverflow;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMessageClamp(
      maxHeight: maxHeight,
      clamp: clamp,
      onOverflow: onOverflow,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderMessageClamp renderObject,
  ) {
    renderObject
      ..maxHeight = maxHeight
      ..clamp = clamp
      ..onOverflow = onOverflow;
  }
}

class _RenderMessageClamp extends RenderProxyBox {
  _RenderMessageClamp({
    required double maxHeight,
    required bool clamp,
    required ValueChanged<bool> onOverflow,
  }) : _maxHeight = maxHeight,
       _clamp = clamp,
       _onOverflow = onOverflow;

  double _maxHeight;
  bool _clamp;
  ValueChanged<bool> _onOverflow;
  var _overflows = false;

  set maxHeight(double value) {
    if (_maxHeight == value) {
      return;
    }
    _maxHeight = value;
    markNeedsLayout();
  }

  set clamp(bool value) {
    if (_clamp == value) {
      return;
    }
    _clamp = value;
    markNeedsLayout();
  }

  set onOverflow(ValueChanged<bool> value) {
    _onOverflow = value;
  }

  BoxConstraints get _childConstraints {
    return constraints.copyWith(minHeight: 0, maxHeight: double.infinity);
  }

  double _heightFor(double childHeight) {
    final overflows = childHeight > _maxHeight + 0.5;
    if (overflows != _overflows) {
      _overflows = overflows;
      _onOverflow(overflows);
    }
    return _clamp && overflows ? _maxHeight : childHeight;
  }

  @override
  void performLayout() {
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    child!.layout(_childConstraints, parentUsesSize: true);
    size = constraints.constrain(
      Size(child!.size.width, _heightFor(child!.size.height)),
    );
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child == null) {
      return constraints.smallest;
    }
    final childSize = child!.getDryLayout(
      constraints.copyWith(minHeight: 0, maxHeight: double.infinity),
    );
    final overflows = childSize.height > _maxHeight + 0.5;
    final height = _clamp && overflows ? _maxHeight : childSize.height;
    return constraints.constrain(Size(childSize.width, height));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }
    if (_clamp && _overflows) {
      context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        super.paint,
      );
      return;
    }
    super.paint(context, offset);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final childHeight = super.computeMinIntrinsicHeight(width);
    if (_clamp && childHeight > _maxHeight) {
      return _maxHeight;
    }
    return childHeight;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final childHeight = super.computeMaxIntrinsicHeight(width);
    if (_clamp && childHeight > _maxHeight) {
      return _maxHeight;
    }
    return childHeight;
  }
}
