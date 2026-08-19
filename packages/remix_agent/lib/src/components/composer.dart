import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../style/defaults.dart';

/// Growable prompt composer.
///
/// Enter submits. Shift+Enter inserts a newline. Enter is ignored while an
/// IME composition is active. While [running] is true the send control
/// becomes stop. Field and send/stop share one surface.
class AgentComposer extends StatefulWidget {
  /// Creates a composer.
  const AgentComposer({
    super.key,
    this.controller,
    this.focusNode,
    this.value,
    this.onChanged,
    this.onSubmit,
    this.onStop,
    this.running = false,
    this.enabled = true,
    this.canSubmit,
    this.autofocus = false,
    this.hintText = 'Message',
    this.minLines = 2,
    this.maxLines = 8,
    this.leading,
    this.trailing,
    this.style,
    this.surfaceStyle,
    this.submitStyle,
    this.stopStyle,
    this.submitLabel = 'Send',
    this.stopLabel = 'Stop',
  });

  /// Optional external text controller.
  final TextEditingController? controller;

  /// Optional focus node.
  final FocusNode? focusNode;

  /// Controlled text. Ignored when [controller] is provided.
  final String? value;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Called with the trimmed prompt when the operator submits.
  final ValueChanged<String>? onSubmit;

  /// Called when the operator stops a live run.
  final VoidCallback? onStop;

  /// True while a run is live. Swaps send for stop.
  final bool running;

  /// When false, the field and send control are inert.
  final bool enabled;

  /// Extra submit gate. ANDed with non-empty text and [onSubmit].
  final bool? canSubmit;

  /// Forwarded to the field.
  final bool autofocus;

  /// Placeholder.
  final String hintText;

  /// Minimum visible lines.
  final int minLines;

  /// Maximum visible lines before the field scrolls.
  final int maxLines;

  /// Optional leading slot (attachments, tools).
  final Widget? leading;

  /// Optional trailing slot besides send/stop (model picker).
  final Widget? trailing;

  /// Optional field style.
  final TextFieldStyler? style;

  /// Optional outer card style.
  final CardStyler? surfaceStyle;

  /// Optional send-button style.
  final IconButtonStyler? submitStyle;

  /// Optional stop-button style.
  final IconButtonStyler? stopStyle;

  /// Accessible name for the submit control.
  final String submitLabel;

  /// Accessible name for the stop control.
  final String stopLabel;

  @override
  State<AgentComposer> createState() => _AgentComposerState();
}

class _AgentComposerState extends State<AgentComposer> {
  TextEditingController? _ownedController;
  late var _text = widget.value ?? widget.controller?.text ?? '';
  final _glyphKey = GlobalKey<_ComposerGlyphState>();

  TextEditingController get _controller {
    return widget.controller ??
        (_ownedController ??= TextEditingController(text: widget.value));
  }

  bool get _isComposing {
    final composing = _controller.value.composing;
    return composing.isValid && !composing.isCollapsed;
  }

  bool get _canSubmit {
    return widget.enabled &&
        !widget.running &&
        _text.trim().isNotEmpty &&
        widget.onSubmit != null &&
        (widget.canSubmit ?? true);
  }

  void _handleChanged(String value) {
    setState(() => _text = value);
    widget.onChanged?.call(value);
  }

  void _submit() {
    if (!_canSubmit || _isComposing) {
      return;
    }
    final prompt = _text.trim();
    widget.onSubmit?.call(prompt);
    _controller.clear();
    setState(() => _text = '');
    widget.onChanged?.call('');
    widget.focusNode?.requestFocus();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    final isEnter =
        event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.numpadEnter;
    if (!isEnter) {
      return KeyEventResult.ignored;
    }
    if (_isComposing) {
      return KeyEventResult.ignored;
    }
    if (HardwareKeyboard.instance.isShiftPressed) {
      return KeyEventResult.ignored;
    }
    _submit();
    return KeyEventResult.handled;
  }

  @override
  void didUpdateWidget(AgentComposer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null &&
        widget.value != null &&
        widget.value != _text &&
        widget.value != oldWidget.value) {
      _controller.value = TextEditingValue(
        text: widget.value!,
        selection: TextSelection.collapsed(offset: widget.value!.length),
      );
      _text = widget.value!;
    }
  }

  @override
  void dispose() {
    _ownedController?.dispose();
    super.dispose();
  }

  Widget _actionIcon(BuildContext _, IconSpec spec, IconData? _) {
    return _ComposerGlyph(key: _glyphKey, spec: spec, stop: widget.running);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: _onKey,
      child: Builder(
        builder: (context) {
          final focused = Focus.of(context).hasFocus;
          var surface =
              widget.surfaceStyle ??
              agentComposerStyle(context, focused: focused);
          if (!widget.enabled) {
            surface = surface.wrap(.opacity(0.6));
          }
          return RemixCard(
            style: surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(
                    context,
                  ).copyWith(scrollbars: false),
                  child: RemixTextArea(
                    controller: _controller,
                    focusNode: widget.focusNode,
                    enabled: widget.enabled,
                    autofocus: widget.autofocus,
                    hintText: widget.hintText,
                    minLines: widget.minLines,
                    maxLines: widget.maxLines,
                    textInputAction: TextInputAction.newline,
                    onChanged: _handleChanged,
                    style: widget.style ?? agentComposerFieldStyle(context),
                  ),
                ),
                const SizedBox(height: 4),
                ConstrainedBox(
                  key: const ValueKey('agent-composer-toolbar'),
                  constraints: const BoxConstraints(
                    minHeight: kAgentComposerControlSize,
                  ),
                  child: Row(
                    spacing: 4,
                    children: [
                      if (widget.leading != null) widget.leading!,
                      const Spacer(),
                      if (widget.trailing != null) widget.trailing!,
                      RemixIconButton(
                        key: ValueKey(
                          widget.running
                              ? 'agent-composer-stop'
                              : 'agent-composer-send',
                        ),
                        icon: null,
                        semanticLabel: widget.running
                            ? widget.stopLabel
                            : widget.submitLabel,
                        enabled: widget.running
                            ? widget.enabled && widget.onStop != null
                            : _canSubmit,
                        onPressed: widget.running ? widget.onStop : _submit,
                        iconBuilder: _actionIcon,
                        style: widget.running
                            ? (widget.stopStyle ??
                                  agentComposerActionStyle(context))
                            : (widget.submitStyle ??
                                  agentComposerActionStyle(context)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ComposerGlyph extends StatefulWidget {
  const _ComposerGlyph({super.key, required this.spec, required this.stop});

  final IconSpec spec;
  final bool stop;

  @override
  State<_ComposerGlyph> createState() => _ComposerGlyphState();
}

class _ComposerGlyphState extends State<_ComposerGlyph> {
  @override
  Widget build(BuildContext context) {
    final color = widget.spec.color ?? const Color(0xFFFFFFFF);
    return SizedBox.square(
      dimension: 16,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          _GlyphMotion(
            visible: !widget.stop,
            child: SizedBox.square(
              dimension: 16,
              child: CustomPaint(painter: _SendArrowPainter(color: color)),
            ),
          ),
          _GlyphMotion(
            visible: widget.stop,
            child: SizedBox.square(
              dimension: 12,
              child: CustomPaint(painter: _StopSquarePainter(color: color)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Send/stop enter from y+3 at scale 0.8; exit to y-3. Reduced motion snaps.
class _GlyphMotion extends StatefulWidget {
  const _GlyphMotion({required this.visible, required this.child});

  final bool visible;
  final Widget child;

  @override
  State<_GlyphMotion> createState() => _GlyphMotionState();
}

class _GlyphMotionState extends State<_GlyphMotion> {
  static const _enterY = 3.0;
  static const _exitY = -3.0;
  static const _hiddenScale = 0.8;

  late var _opacity = widget.visible ? 1.0 : 0.0;
  late var _scale = widget.visible ? 1.0 : _hiddenScale;
  late var _y = widget.visible ? 0.0 : _enterY;
  var _snap = true;

  AnimationConfig _motion(bool reduce) {
    if (reduce || _snap) {
      return AnimationConfig.linear(Duration.zero);
    }
    return AnimationConfig.springDescription(
      mass: 0.55,
      stiffness: 460,
      damping: 30,
    );
  }

  @override
  void didUpdateWidget(_GlyphMotion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.visible == widget.visible) {
      return;
    }
    if (widget.visible) {
      setState(() {
        _snap = true;
        _opacity = 0;
        _scale = _hiddenScale;
        _y = _enterY;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !widget.visible) {
          return;
        }
        setState(() {
          _snap = false;
          _opacity = 1;
          _scale = 1;
          _y = 0;
        });
      });
      return;
    }
    setState(() {
      _snap = false;
      _opacity = 0;
      _scale = _hiddenScale;
      _y = _exitY;
    });
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final opacity = reduce ? (widget.visible ? 1.0 : 0.0) : _opacity;
    final scale = reduce ? 1.0 : _scale;
    final y = reduce ? 0.0 : _y;
    return Box(
      style: BoxStyler()
          .wrap(
            WidgetModifierConfig.opacity(
              opacity,
            ).scale(scale, scale).translate(x: 0, y: y),
          )
          .animate(_motion(reduce)),
      child: widget.child,
    );
  }
}

class _SendArrowPainter extends CustomPainter {
  const _SendArrowPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * (2 / 24)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawLine(Offset(cx, s * 19 / 24), Offset(cx, s * 5 / 24), paint);
    canvas.drawPath(
      Path()
        ..moveTo(cx - s * 7 / 24, cy)
        ..lineTo(cx, s * 5 / 24)
        ..lineTo(cx + s * 7 / 24, cy),
      paint,
    );
  }

  @override
  bool shouldRepaint(_SendArrowPainter oldDelegate) =>
      color != oldDelegate.color;
}

class _StopSquarePainter extends CustomPainter {
  const _StopSquarePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // 12px icon; filled square inset 3/24 with rx 2/24 (~9×9).
    final s = size.shortestSide;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: s * 18 / 24,
          height: s * 18 / 24,
        ),
        Radius.circular(s * 2 / 24),
      ),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_StopSquarePainter oldDelegate) =>
      color != oldDelegate.color;
}
