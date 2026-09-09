import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../models/statuses.dart';
import '../style/style_builder.dart';

part 'message.g.dart';

enum AgentMessageAlign { start, end }

/// Groups chronological message rows without imposing visual chrome.
class AgentMessageGroup extends StatelessWidget {
  const AgentMessageGroup({
    super.key,
    required this.children,
    this.spacing = 0,
  });

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    spacing: spacing,
    children: children,
  );
}

/// Sender-aware message row. Message bodies are never clamped automatically.
class AgentMessage extends StatelessWidget {
  const AgentMessage({
    super.key,
    required this.role,
    required this.child,
    this.align,
    this.avatar,
    this.showAvatar = false,
    this.placeholderAvatar = false,
    this.maxWidth,
    this.header,
    this.footer,
    this.semanticLabel,
    this.surfaceStyle = const CardStyler.create(),
    this.style = const AgentMessageStyler.create(),
    this.styleSpec,
  });

  final AgentRole role;
  final Widget child;
  final AgentMessageAlign? align;
  final Widget? avatar;
  final bool showAvatar;
  final bool placeholderAvatar;
  final double? maxWidth;
  final Widget? header;
  final Widget? footer;
  final String? semanticLabel;
  final CardStyler surfaceStyle;
  final AgentMessageStyler style;
  final AgentMessageSpec? styleSpec;

  bool get _alignEnd =>
      (align ??
          (role == AgentRole.user
              ? AgentMessageAlign.end
              : AgentMessageAlign.start)) ==
      AgentMessageAlign.end;

  @override
  Widget build(BuildContext context) {
    return AgentStyleBuilder<AgentMessageSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        final body = RemixCard(
          style: surfaceStyle,
          child: Box(styleSpec: spec.body, child: child),
        );
        final cap = maxWidth ?? spec.maxWidth;
        final constrained = cap == null
            ? body
            : ConstrainedBox(
                constraints: BoxConstraints(maxWidth: cap),
                child: body,
              );
        final stack = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: _alignEnd
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (header != null) Box(styleSpec: spec.header, child: header),
            constrained,
            if (footer != null) Box(styleSpec: spec.footer, child: footer),
          ],
        );
        final avatarSlot = _avatarSlot(spec);
        final row = RowBox(
          styleSpec: spec.row,
          children: [
            if (!_alignEnd && avatarSlot != null) avatarSlot,
            Flexible(
              fit: FlexFit.loose,
              child: Align(
                widthFactor: 1,
                alignment: _alignEnd
                    ? AlignmentDirectional.centerEnd
                    : AlignmentDirectional.centerStart,
                child: stack,
              ),
            ),
            if (_alignEnd && avatarSlot != null) avatarSlot,
          ],
        );
        return Semantics(
          container: true,
          explicitChildNodes: true,
          label:
              semanticLabel ??
              (role == AgentRole.user ? 'User message' : 'Assistant message'),
          child: row,
        );
      },
    );
  }

  Widget? _avatarSlot(AgentMessageSpec spec) {
    if (placeholderAvatar) return Box(styleSpec: spec.avatar);
    if (!showAvatar || avatar == null) return null;
    return Box(styleSpec: spec.avatar, child: avatar);
  }
}

/// Explicit, opt-in clipping for noninteractive message copy.
///
/// Do not place buttons, links, or other interactive descendants in [child].
/// While collapsed, the whole child remains readable to assistive technology
/// but is removed from pointer input, focus, and traversal.
class AgentMessageCollapsible extends StatefulWidget {
  const AgentMessageCollapsible({
    super.key,
    required this.child,
    this.expanded,
    this.defaultExpanded = false,
    this.onExpandedChanged,
    this.showMoreLabel = 'Show more',
    this.showLessLabel = 'Show less',
    this.toggleStyle = const ButtonStyler.create(),
    this.style = const AgentMessageCollapsibleStyler.create(),
    this.styleSpec,
  });

  final Widget child;
  final bool? expanded;
  final bool defaultExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final String showMoreLabel;
  final String showLessLabel;
  final ButtonStyler toggleStyle;
  final AgentMessageCollapsibleStyler style;
  final AgentMessageCollapsibleSpec? styleSpec;

  @override
  State<AgentMessageCollapsible> createState() =>
      _AgentMessageCollapsibleState();
}

class _AgentMessageCollapsibleState extends State<AgentMessageCollapsible> {
  late bool _uncontrolledExpanded;
  bool _overflows = false;

  bool get _expanded => widget.expanded ?? _uncontrolledExpanded;

  @override
  void initState() {
    super.initState();
    _uncontrolledExpanded = widget.expanded ?? widget.defaultExpanded;
  }

  @override
  void didUpdateWidget(AgentMessageCollapsible oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expanded != null && widget.expanded == null) {
      _uncontrolledExpanded = oldWidget.expanded!;
    }
  }

  void _toggle() {
    final next = !_expanded;
    if (widget.expanded == null) {
      setState(() => _uncontrolledExpanded = next);
    }
    widget.onExpandedChanged?.call(next);
  }

  void _handleOverflow(bool value) {
    if (value == _overflows) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && value != _overflows) setState(() => _overflows = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AgentStyleBuilder<AgentMessageCollapsibleSpec>(
      style: widget.style,
      styleSpec: widget.styleSpec,
      builder: (context, spec) {
        final height = spec.collapsedHeight;
        final collapsed = !_expanded && height != null;
        Widget content = _OverflowClip(
          maxHeight: height,
          clip: collapsed,
          onOverflowChanged: _handleOverflow,
          child: Box(styleSpec: spec.clipped, child: widget.child),
        );
        if (collapsed) {
          content = IgnorePointer(
            child: Focus(
              canRequestFocus: false,
              skipTraversal: true,
              descendantsAreFocusable: false,
              descendantsAreTraversable: false,
              child: content,
            ),
          );
        }
        return Box(
          styleSpec: spec.container,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              content,
              if (_overflows)
                RemixButton(
                  label: _expanded
                      ? widget.showLessLabel
                      : widget.showMoreLabel,
                  semanticLabel: _expanded
                      ? widget.showLessLabel
                      : widget.showMoreLabel,
                  onPressed: _toggle,
                  style: widget.toggleStyle,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _OverflowClip extends SingleChildRenderObjectWidget {
  const _OverflowClip({
    required this.maxHeight,
    required this.clip,
    required this.onOverflowChanged,
    required super.child,
  });

  final double? maxHeight;
  final bool clip;
  final ValueChanged<bool> onOverflowChanged;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderOverflowClip(maxHeight, clip, onOverflowChanged);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderOverflowClip renderObject,
  ) {
    renderObject
      ..maxHeight = maxHeight
      ..clip = clip
      ..onOverflowChanged = onOverflowChanged;
  }
}

class _RenderOverflowClip extends RenderProxyBox {
  _RenderOverflowClip(this._maxHeight, this._clip, this.onOverflowChanged);

  double? _maxHeight;
  bool _clip;
  ValueChanged<bool> onOverflowChanged;
  bool _reportedOverflow = false;

  set maxHeight(double? value) {
    if (value == _maxHeight) return;
    _maxHeight = value;
    markNeedsLayout();
  }

  set clip(bool value) {
    if (value == _clip) return;
    _clip = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final current = child;
    if (current == null) {
      size = constraints.smallest;
      return;
    }
    current.layout(
      constraints.copyWith(minHeight: 0, maxHeight: double.infinity),
      parentUsesSize: true,
    );
    final limit = _maxHeight;
    final overflow = limit != null && current.size.height > limit;
    size = constraints.constrain(
      Size(current.size.width, _clip && overflow ? limit : current.size.height),
    );
    if (overflow != _reportedOverflow) {
      _reportedOverflow = overflow;
      onOverflowChanged(overflow);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    if (!_clip) {
      super.paint(context, offset);
      return;
    }
    // pushClipRect applies the paint offset to this local rectangle.
    context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      super.paint,
    );
  }
}

@MixableSpec(target: AgentMessage.new)
@immutable
final class AgentMessageSpec with _$AgentMessageSpec {
  @override
  final double? maxWidth;
  @override
  final StyleSpec<FlexBoxSpec> row;
  @override
  final StyleSpec<BoxSpec> avatar;
  @override
  final StyleSpec<BoxSpec> header;
  @override
  final StyleSpec<BoxSpec> body;
  @override
  final StyleSpec<BoxSpec> footer;

  const AgentMessageSpec({
    this.maxWidth,
    StyleSpec<FlexBoxSpec>? row,
    StyleSpec<BoxSpec>? avatar,
    StyleSpec<BoxSpec>? header,
    StyleSpec<BoxSpec>? body,
    StyleSpec<BoxSpec>? footer,
  }) : row = row ?? const StyleSpec(spec: FlexBoxSpec()),
       avatar = avatar ?? const StyleSpec(spec: BoxSpec()),
       header = header ?? const StyleSpec(spec: BoxSpec()),
       body = body ?? const StyleSpec(spec: BoxSpec()),
       footer = footer ?? const StyleSpec(spec: BoxSpec());
}

@MixableSpec(target: AgentMessageCollapsible.new)
@immutable
final class AgentMessageCollapsibleSpec with _$AgentMessageCollapsibleSpec {
  @override
  final double? collapsedHeight;
  @override
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<BoxSpec> clipped;

  const AgentMessageCollapsibleSpec({
    this.collapsedHeight,
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? clipped,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       clipped = clipped ?? const StyleSpec(spec: BoxSpec());
}
