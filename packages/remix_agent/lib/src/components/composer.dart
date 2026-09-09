import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../style/functional_glyph.dart';
import '../style/style_builder.dart';

part 'composer.g.dart';

/// Growable prompt input composed from Remix text-area and icon-button controls.
class AgentComposer extends StatefulWidget {
  const AgentComposer({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.onChanged,
    this.onSubmit,
    this.onStop,
    this.running = false,
    this.enabled = true,
    this.canSubmit,
    this.clearOnSubmit = true,
    this.autofocus = false,
    this.hintText = 'Message',
    this.semanticLabel = 'Message',
    this.minLines = 2,
    this.maxLines = 8,
    this.leading,
    this.trailing,
    this.submitIconBuilder,
    this.stopIconBuilder,
    this.submitLabel = 'Send',
    this.stopLabel = 'Stop',
    this.surfaceStyle = const CardStyler.create(),
    this.fieldStyle = const TextFieldStyler.create(),
    this.submitStyle = const IconButtonStyler.create(),
    this.stopStyle = const IconButtonStyler.create(),
    this.style = const AgentComposerStyler.create(),
    this.styleSpec,
  }) : assert(
         controller == null || initialValue == null,
         'initialValue cannot be used with an external controller.',
       );

  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? onStop;
  final bool running;
  final bool enabled;
  final bool? canSubmit;
  final bool clearOnSubmit;
  final bool autofocus;
  final String hintText;
  final String semanticLabel;
  final int minLines;
  final int maxLines;
  final Widget? leading;
  final Widget? trailing;
  final RemixIconButtonIconBuilder? submitIconBuilder;
  final RemixIconButtonIconBuilder? stopIconBuilder;
  final String submitLabel;
  final String stopLabel;
  final CardStyler surfaceStyle;
  final TextFieldStyler fieldStyle;
  final IconButtonStyler submitStyle;
  final IconButtonStyler stopStyle;
  final AgentComposerStyler style;
  final AgentComposerSpec? styleSpec;

  @override
  State<AgentComposer> createState() => _AgentComposerState();
}

class _AgentComposerState extends State<AgentComposer> {
  TextEditingController? _ownedController;
  FocusNode? _ownedFocusNode;
  late TextEditingController _controller;
  late String _text;

  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownedFocusNode ??= FocusNode());

  bool get _isComposing {
    final composing = _controller.value.composing;
    return composing.isValid && !composing.isCollapsed;
  }

  bool get _canSubmit =>
      widget.enabled &&
      !widget.running &&
      _text.trim().isNotEmpty &&
      widget.onSubmit != null &&
      (widget.canSubmit ?? true);

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ??
        (_ownedController = TextEditingController(text: widget.initialValue));
    _text = _controller.text;
    _controller.addListener(_handleControllerChanged);
  }

  void _handleControllerChanged() {
    final next = _controller.text;
    if (next == _text) return;
    setState(() => _text = next);
    widget.onChanged?.call(next);
  }

  @override
  void didUpdateWidget(AgentComposer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.controller, widget.controller)) {
      final seed = _controller.text;
      _controller.removeListener(_handleControllerChanged);
      _ownedController?.dispose();
      _ownedController = null;
      _controller =
          widget.controller ??
          (_ownedController = TextEditingController(text: seed));
      _text = _controller.text;
      _controller.addListener(_handleControllerChanged);
    }
    if (!identical(oldWidget.focusNode, widget.focusNode)) {
      _ownedFocusNode?.dispose();
      _ownedFocusNode = null;
    }
  }

  void _submit() {
    if (!_canSubmit || _isComposing) return;
    final prompt = _text.trim();
    widget.onSubmit?.call(prompt);
    if (widget.clearOnSubmit) _controller.clear();
    _focusNode.requestFocus();
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final isEnter =
        event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.numpadEnter;
    if (!isEnter || HardwareKeyboard.instance.isShiftPressed || _isComposing) {
      return KeyEventResult.ignored;
    }
    if (!_canSubmit) return KeyEventResult.ignored;
    _submit();
    return KeyEventResult.handled;
  }

  Widget _defaultSubmitIcon(
    BuildContext context,
    IconSpec spec,
    IconData? icon,
  ) => AgentFunctionalGlyph(kind: .send, spec: spec);

  Widget _defaultStopIcon(
    BuildContext context,
    IconSpec spec,
    IconData? icon,
  ) => AgentFunctionalGlyph(kind: .stop, spec: spec);

  @override
  Widget build(BuildContext context) {
    return AgentStyleBuilder<AgentComposerSpec>(
      style: widget.style,
      styleSpec: widget.styleSpec,
      // Keep the field and action in separate accessibility nodes.
      builder: (context, spec) => Semantics(
        container: true,
        explicitChildNodes: true,
        label: widget.semanticLabel,
        child: Focus(
          canRequestFocus: false,
          skipTraversal: true,
          onKeyEvent: _handleKey,
          child: RemixCard(
            style: widget.surfaceStyle,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(
                    context,
                  ).copyWith(scrollbars: false),
                  child: RemixTextArea(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: widget.enabled,
                    autofocus: widget.autofocus,
                    hintText: widget.hintText,
                    semanticLabel: widget.semanticLabel,
                    minLines: widget.minLines,
                    maxLines: widget.maxLines,
                    textInputAction: TextInputAction.newline,
                    style: widget.fieldStyle,
                  ),
                ),
                RowBox(
                  styleSpec: spec.toolbar,
                  children: [
                    if (widget.leading != null) widget.leading!,
                    const Spacer(),
                    if (widget.trailing != null) widget.trailing!,
                    Semantics(
                      container: true,
                      child: RemixIconButton(
                        key: ValueKey(
                          widget.running
                              ? 'agent-composer-stop'
                              : 'agent-composer-send',
                        ),
                        icon: null,
                        iconBuilder: widget.running
                            ? (widget.stopIconBuilder ?? _defaultStopIcon)
                            : (widget.submitIconBuilder ?? _defaultSubmitIcon),
                        semanticLabel: widget.running
                            ? widget.stopLabel
                            : widget.submitLabel,
                        enabled: widget.running
                            ? widget.enabled && widget.onStop != null
                            : _canSubmit,
                        onPressed: widget.running ? widget.onStop : _submit,
                        style: widget.running
                            ? widget.stopStyle
                            : widget.submitStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    _ownedController?.dispose();
    _ownedFocusNode?.dispose();
    super.dispose();
  }
}

@MixableSpec(target: AgentComposer.new)
@immutable
final class AgentComposerSpec with _$AgentComposerSpec {
  @override
  final StyleSpec<FlexBoxSpec> toolbar;

  const AgentComposerSpec({StyleSpec<FlexBoxSpec>? toolbar})
    : toolbar = toolbar ?? const StyleSpec(spec: FlexBoxSpec());
}
