import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';

/// Carbon radio visual recipe.
RadioStyler carbonRadioButtonStyle() => .new()
    .size(18, 18)
    .borderRadius(.all(.circular(9)))
    .color(const Color(0x00000000))
    .border(
      BoxBorderMix.all(
        BorderSideMix(color: CarbonTokens.iconPrimary(), width: 1),
      ),
    )
    .indicator(
      BoxStyler()
          .size(9, 9)
          .borderRadius(.all(.circular(4.5)))
          .color(CarbonTokens.iconPrimary()),
    )
    .containerEffects(
      RemixBoxEffectsMix(
        outline: BorderSideMix(color: const Color(0x00000000), width: 2),
        outlineOffset: 1,
      ),
    )
    .onHovered(
      RadioStyler().border(
        BoxBorderMix.all(
          BorderSideMix(color: CarbonTokens.iconPrimary(), width: 2),
        ),
      ),
    )
    .onFocusVisible(
      RadioStyler().containerEffects(
        RemixBoxEffectsMix(
          outline: BorderSideMix(color: CarbonTokens.focus(), width: 2),
          outlineOffset: 1,
        ),
      ),
    )
    .onDisabled(
      RadioStyler()
          .border(
            BoxBorderMix.all(
              BorderSideMix(color: CarbonTokens.borderDisabled(), width: 1),
            ),
          )
          .indicator(BoxStyler().color(CarbonTokens.iconDisabled())),
    );

/// A controlled Carbon radio group with native roving keyboard behavior.
class CarbonRadioButtonGroup<T> extends StatelessWidget {
  const CarbonRadioButtonGroup({
    super.key,
    required this.groupValue,
    required this.child,
    this.onChanged,
    this.enabled = true,
    this.semanticLabel,
  });

  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final String? semanticLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final effectiveEnabled = enabled && onChanged != null;

    return Semantics(
      role: .radioGroup,
      label: semanticLabel,
      container: true,
      explicitChildNodes: true,
      child: RadioGroup<T>(
        groupValue: groupValue,
        onChanged: effectiveEnabled ? onChanged! : _ignoreRadioChange,
        child: _CarbonRadioGroupScope<T>(
          enabled: effectiveEnabled,
          child: child,
        ),
      ),
    );
  }
}

// RadioGroup requires a callback even when every descendant is disabled.
// ignore: no-empty-block
void _ignoreRadioChange<T>(T? _) {}

/// A labeled Carbon radio option.
class CarbonRadioButton<T> extends StatelessWidget {
  const CarbonRadioButton({
    super.key,
    required this.value,
    required this.label,
    this.enabled = true,
    this.toggleable = false,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  });

  final T value;
  final String label;
  final bool enabled;
  final bool toggleable;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final groupEnabled = _CarbonRadioGroupScope.maybeOf<T>(context)?.enabled;
    final effectiveEnabled = enabled && (groupEnabled ?? true);
    final registry = RadioGroup.maybeOf<T>(context);

    return GestureDetector(
      behavior: .translucent,
      excludeFromSemantics: true,
      onTap: effectiveEnabled && registry != null
          ? () => registry.onChanged(value)
          : null,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Row(
          mainAxisSize: .min,
          children: [
            RemixRadio<T>(
              value: value,
              enabled: effectiveEnabled,
              toggleable: toggleable,
              focusNode: focusNode,
              autofocus: autofocus,
              semanticLabel: semanticLabel ?? label,
              style: carbonRadioButtonStyle(),
            ),
            SizedBox(width: CarbonTokens.spacing03.resolve(context)),
            ExcludeSemantics(
              child: StyledText(
                label,
                style: TextStyler()
                    .style(CarbonTokens.bodyCompact01.mix())
                    .color(
                      effectiveEnabled
                          ? CarbonTokens.textPrimary()
                          : CarbonTokens.textDisabled(),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarbonRadioGroupScope<T> extends InheritedWidget {
  const _CarbonRadioGroupScope({required this.enabled, required super.child});

  final bool enabled;

  static _CarbonRadioGroupScope<T>? maybeOf<T>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(_CarbonRadioGroupScope<T> oldWidget) =>
      enabled != oldWidget.enabled;
}
