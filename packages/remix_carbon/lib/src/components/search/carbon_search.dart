import 'package:flutter/widgets.dart';

import '../../foundation/carbon_layout_scope.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_icon_button_style.dart';
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
      leading: ExcludeSemantics(
        child: Icon(
          CarbonIcons.search,
          size: CarbonTokens.iconSize01.resolve(context),
          color: CarbonTokens.iconSecondary.resolve(context),
        ),
      ),
      trailing: canClear
          ? SizedBox.square(
              dimension: size.height,
              child: CarbonIconButton(
                icon: CarbonIcons.close,
                semanticLabel: widget.clearButtonLabel,
                kind: .ghost,
                size: size,
                onPressed: _clear,
                style: carbonIconButtonForegroundStyle(
                  CarbonTokens.iconPrimary,
                ),
              ),
            )
          : null,
    );
  }
}
