import 'dart:ui' show SemanticsRole;

import 'package:flutter/widgets.dart';

typedef CarbonActionSurfaceBuilder =
    Widget Function(
      BuildContext context,
      bool focused,
      bool hovered,
      bool pressed,
    );

/// Material-free pointer and keyboard interaction shared by Carbon composites.
class CarbonActionSurface extends StatefulWidget {
  const CarbonActionSurface({
    super.key,
    required this.builder,
    required this.semanticLabel,
    this.onPressed,
    this.enabled = true,
    this.selected,
    this.expanded,
    this.focusNode,
    this.autofocus = false,
    this.excludeChildSemantics = false,
    this.role,
    this.button = true,
    this.link = false,
  });

  final CarbonActionSurfaceBuilder builder;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool? selected;
  final bool? expanded;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool excludeChildSemantics;
  final SemanticsRole? role;
  final bool button;
  final bool link;

  @override
  State<CarbonActionSurface> createState() => _CarbonActionSurfaceState();
}

class _CarbonActionSurfaceState extends State<CarbonActionSurface> {
  var _focused = false;
  var _hovered = false;
  var _pressed = false;

  bool get _interactive => widget.enabled && widget.onPressed != null;

  void _activate() => widget.onPressed?.call();

  @override
  Widget build(BuildContext context) => Semantics(
    label: widget.semanticLabel,
    role: widget.role,
    container: true,
    explicitChildNodes: !widget.excludeChildSemantics,
    button: widget.button,
    link: widget.link,
    enabled: _interactive,
    selected: widget.selected,
    expanded: widget.expanded,
    focusable: _interactive,
    focused: _focused,
    onTap: _interactive ? _activate : null,
    excludeSemantics: widget.excludeChildSemantics,
    child: MouseRegion(
      cursor: _interactive
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: _interactive ? (_) => setState(() => _hovered = true) : null,
      onExit: _interactive ? (_) => setState(() => _hovered = false) : null,
      child: GestureDetector(
        behavior: .opaque,
        excludeFromSemantics: true,
        onTap: _interactive ? _activate : null,
        onTapDown: _interactive ? (_) => setState(() => _pressed = true) : null,
        onTapUp: _interactive ? (_) => setState(() => _pressed = false) : null,
        onTapCancel: _interactive
            ? () => setState(() => _pressed = false)
            : null,
        child: FocusableActionDetector(
          enabled: _interactive,
          includeFocusSemantics: false,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          onShowFocusHighlight: (value) => setState(() => _focused = value),
          shortcuts: const {
            SingleActivator(.enter): ActivateIntent(),
            SingleActivator(.space): ActivateIntent(),
          },
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) {
                _activate();

                return true;
              },
            ),
          },
          child: widget.builder(context, _focused, _hovered, _pressed),
        ),
      ),
    ),
  );
}
