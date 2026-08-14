import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layout_scope.dart';
import '../button/carbon_button.dart';
import '../text_input/carbon_text_input.dart';

/// Carbon numeric field with accessible increment and decrement controls.
class CarbonNumberInput extends StatefulWidget {
  const CarbonNumberInput({
    super.key,
    this.value = 0,
    this.min,
    this.max,
    this.step = 1,
    this.stepStartValue = 0,
    this.label,
    this.helperText,
    this.error = false,
    this.enabled = true,
    this.readOnly = false,
    this.hideSteppers = false,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
    this.size = .md,
    this.semanticLabel,
  }) : assert(step > 0),
       assert(min == null || max == null || min <= max);

  final num? value;
  final num? min;
  final num? max;
  final num step;
  final num stepStartValue;
  final String? label;
  final String? helperText;
  final bool error;
  final bool enabled;
  final bool readOnly;
  final bool hideSteppers;
  final ValueChanged<num>? onChanged;
  final FocusNode? focusNode;
  final bool autofocus;
  final CarbonSize size;
  final String? semanticLabel;

  @override
  State<CarbonNumberInput> createState() => _CarbonNumberInputState();
}

class _CarbonNumberInputState extends State<CarbonNumberInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _format(widget.value));
  }

  @override
  void didUpdateWidget(CarbonNumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      final text = _format(widget.value);
      _controller.value = _controller.value.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
        composing: .empty,
      );
    }
  }

  static String _format(num? value) {
    if (value == null) return '';

    return value is double && value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toString();
  }

  num get _current => num.tryParse(_controller.text) ?? widget.stepStartValue;

  num _clamp(num value) {
    final min = widget.min;
    final max = widget.max;
    if (min != null && value < min) return min;
    if (max != null && value > max) return max;

    return value;
  }

  bool get _canChange =>
      widget.enabled && !widget.readOnly && widget.onChanged != null;

  void _change(num next) {
    final value = _clamp(next);
    final text = _format(value);
    _controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    widget.onChanged?.call(value);
  }

  void _handleTextChanged(String text) {
    final value = num.tryParse(text);
    if (value != null) widget.onChanged?.call(value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _current;
    final decrease = _clamp(current - widget.step);
    final increase = _clamp(current + widget.step);
    final label = widget.semanticLabel ?? widget.label ?? 'Number';
    final controls = widget.hideSteppers
        ? null
        : Row(
            mainAxisSize: .min,
            children: [
              _stepper(
                symbol: '−',
                semanticLabel: 'Decrease $label',
                onPressed: _canChange && decrease != current
                    ? () => _change(current - widget.step)
                    : null,
              ),
              _stepper(
                symbol: '+',
                semanticLabel: 'Increase $label',
                onPressed: _canChange && increase != current
                    ? () => _change(current + widget.step)
                    : null,
              ),
            ],
          );

    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: label,
      value: _format(current),
      increasedValue: _format(increase),
      decreasedValue: _format(decrease),
      onIncrease: _canChange && increase != current
          ? () => _change(current + widget.step)
          : null,
      onDecrease: _canChange && decrease != current
          ? () => _change(current - widget.step)
          : null,
      child: CarbonTextInput(
        controller: _controller,
        focusNode: widget.focusNode,
        label: widget.label,
        helperText: widget.helperText,
        error: widget.error,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: .done,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[-+0-9.,]')),
        ],
        onChanged: _handleTextChanged,
        semanticLabel: label,
        size: widget.size.clampTo(.sm, .lg),
        trailing: controls,
      ),
    );
  }

  Widget _stepper({
    required String symbol,
    required String semanticLabel,
    required VoidCallback? onPressed,
  }) => SizedBox.square(
    dimension: widget.size.clampTo(.sm, .lg).height,
    child: RemixButton(
      style: carbonButtonStyle(
        kind: .ghost,
        size: widget.size.clampTo(.sm, .lg),
      ).padding(.all(0)).spacing(0).mainAxisAlignment(.center),
      label: symbol,
      semanticLabel: semanticLabel,
      onPressed: onPressed,
    ),
  );
}
