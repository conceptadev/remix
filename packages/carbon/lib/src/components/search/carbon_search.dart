import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layout_scope.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../button/carbon_button.dart';
import '../text_input/carbon_text_input.dart';

/// Carbon search input with a persistent search glyph and conditional clear action.
class CarbonSearch extends StatefulWidget {
  const CarbonSearch({
    super.key,
    required this.labelText,
    this.controller,
    this.focusNode,
    this.placeholder = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.enabled = true,
    this.autofocus = false,
    this.size,
    this.clearButtonLabel = 'Clear search',
  });

  final String labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool enabled;
  final bool autofocus;
  final CarbonSize? size;
  final String clearButtonLabel;

  @override
  State<CarbonSearch> createState() => _CarbonSearchState();
}

class _CarbonSearchState extends State<CarbonSearch> {
  late TextEditingController _controller;
  late bool _ownsController;
  late String _text;

  @override
  void initState() {
    super.initState();
    _attachController(widget.controller);
  }

  @override
  void didUpdateWidget(CarbonSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _detachController();
      _attachController(widget.controller);
    }
  }

  void _attachController(TextEditingController? controller) {
    _ownsController = controller == null;
    _controller = controller ?? TextEditingController();
    _text = _controller.text;
    _controller.addListener(_handleControllerChanged);
  }

  void _detachController() {
    _controller.removeListener(_handleControllerChanged);
    if (_ownsController) _controller.dispose();
  }

  void _handleControllerChanged() {
    final next = _controller.text;
    if (mounted && next != _text) setState(() => _text = next);
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
    widget.focusNode?.requestFocus();
  }

  @override
  void dispose() {
    _detachController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = (widget.size ?? CarbonSize.md).clampTo(.xs, .lg);
    final canClear = widget.enabled && _text.isNotEmpty;

    return CarbonTextInput(
      controller: _controller,
      focusNode: widget.focusNode,
      hintText: widget.placeholder,
      keyboardType: .text,
      textInputAction: .search,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      semanticLabel: widget.labelText,
      size: size,
      leading: const ExcludeSemantics(child: _CarbonSearchGlyph()),
      trailing: canClear
          ? SizedBox.square(
              dimension: size.height,
              child: RemixButton(
                style: carbonButtonStyle(
                  kind: .ghost,
                  size: size,
                ).padding(.all(0)).spacing(0).mainAxisAlignment(.center),
                label: '×',
                semanticLabel: widget.clearButtonLabel,
                onPressed: _clear,
              ),
            )
          : null,
    );
  }
}

class _CarbonSearchGlyph extends StatelessWidget {
  const _CarbonSearchGlyph();

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: const Size.square(16),
    painter: _CarbonSearchGlyphPainter(
      CarbonTokens.iconSecondary.resolve(context),
    ),
  );
}

class _CarbonSearchGlyphPainter extends CustomPainter {
  const _CarbonSearchGlyphPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = .stroke
      ..strokeWidth = 1.5
      ..strokeCap = .square;
    canvas.drawCircle(const Offset(6.5, 6.5), 4.75, paint);
    canvas.drawLine(const Offset(10, 10), const Offset(14.5, 14.5), paint);
  }

  @override
  bool shouldRepaint(_CarbonSearchGlyphPainter oldDelegate) =>
      oldDelegate.color != color;
}
