import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';

part 'carbon_checkbox.g.dart';

/// Carbon checkbox recipe generated directly over [RemixCheckbox].
@MixWidget(
  target: RemixCheckbox.new,
  widgetParameters: .only({
    'selected',
    'onChanged',
    'enabled',
    'tristate',
    'checkedIcon',
    'uncheckedIcon',
    'indeterminateIcon',
    'focusNode',
    'autofocus',
    'enableFeedback',
    'label',
    'semanticLabel',
    'minimumTapTargetSize',
    'mouseCursor',
  }),
)
CheckboxStyler carbonCheckboxStyle() {
  final base = CheckboxStyler()
      .size(16, 16)
      .borderRadius(.all(.circular(2)))
      .color(const Color(0x00000000))
      .border(
        BoxBorderMix.all(
          BorderSideMix(color: CarbonTokens.iconPrimary(), width: 1),
        ),
      )
      .indicator(IconStyler().size(12).color(CarbonTokens.iconInverse()))
      .label(
        TextStyler()
            .style(CarbonTokens.bodyCompact01.mix())
            .color(CarbonTokens.textPrimary()),
      )
      .labelSpacing(CarbonTokens.spacing03())
      .containerEffects(
        RemixBoxEffectsMix(
          outline: BorderSideMix(color: const Color(0x00000000), width: 2),
          outlineOffset: 1,
        ),
      );

  return base
      .onSelected(
        CheckboxStyler()
            .color(CarbonTokens.iconPrimary())
            .border(
              BoxBorderMix.all(
                BorderSideMix(color: CarbonTokens.iconPrimary(), width: 1),
              ),
            ),
      )
      .onHovered(
        CheckboxStyler().border(
          BoxBorderMix.all(
            BorderSideMix(color: CarbonTokens.iconPrimary(), width: 2),
          ),
        ),
      )
      .onFocusVisible(
        CheckboxStyler().containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(color: CarbonTokens.focus(), width: 2),
            outlineOffset: 1,
          ),
        ),
      )
      .onDisabled(
        CheckboxStyler()
            .color(const Color(0x00000000))
            .border(
              BoxBorderMix.all(
                BorderSideMix(color: CarbonTokens.borderDisabled(), width: 1),
              ),
            )
            .indicator(IconStyler().color(CarbonTokens.iconDisabled()))
            .label(TextStyler().color(CarbonTokens.textDisabled())),
      );
}

/// Typed Carbon checkbox-group coordinator.
class CarbonCheckboxGroup<T extends Object> extends StatelessWidget {
  const CarbonCheckboxGroup({
    super.key,
    required this.values,
    required this.child,
    this.onChanged,
    this.enabled = true,
    this.isRequired = false,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final Set<T> values;
  final Widget child;
  final ValueChanged<Set<T>>? onChanged;
  final bool enabled;
  final bool isRequired;
  final String? semanticLabel;
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) => RemixCheckboxGroup<T>(
    values: values,
    onChanged: onChanged,
    enabled: enabled,
    isRequired: isRequired,
    semanticLabel: semanticLabel,
    excludeSemantics: excludeSemantics,
    child: child,
  );
}

/// A labeled option inside [CarbonCheckboxGroup].
class CarbonCheckboxGroupItem<T extends Object> extends StatelessWidget {
  const CarbonCheckboxGroupItem({
    super.key,
    required this.value,
    required this.label,
    this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.minimumTapTargetSize = const Size.square(48),
    this.mouseCursor = SystemMouseCursors.click,
  });

  final T value;
  final String label;
  final String? semanticLabel;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enableFeedback;
  final Size minimumTapTargetSize;
  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) => RemixCheckboxGroupItem<T>(
    value: value,
    label: label,
    semanticLabel: semanticLabel,
    enabled: enabled,
    focusNode: focusNode,
    autofocus: autofocus,
    enableFeedback: enableFeedback,
    minimumTapTargetSize: minimumTapTargetSize,
    mouseCursor: mouseCursor,
    style: carbonCheckboxStyle(),
  );
}
