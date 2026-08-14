import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../foundation/carbon_layout_scope.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

const _carbonContentSwitcherHover = ContextToken(
  _resolveCarbonContentSwitcherHover,
);

Color _resolveCarbonContentSwitcherHover(BuildContext context) =>
    CarbonLayer.of(context).color(.layerHover).resolve(context);

/// Carbon content-switcher recipe over Remix's single-select segmented control.
SegmentedControlStyler carbonContentSwitcherStyle({CarbonSize? size}) {
  final height = (size ?? CarbonSize.md).clampTo(.sm, .lg).height;
  final item = SegmentedControlItemStyler()
      .minHeight(height)
      .padding(
        .symmetric(
          horizontal: CarbonTokens.spacing05(),
          vertical: CarbonTokens.spacing03(),
        ),
      )
      .spacing(CarbonTokens.spacing03())
      .label(
        TextStyler()
            .style(CarbonTokens.bodyCompact01.mix())
            .color(CarbonTokens.textSecondary())
            .maxLines(1)
            .overflow(.ellipsis),
      )
      .icon(
        IconStyler()
            .size(CarbonTokens.iconSize01())
            .color(CarbonTokens.iconSecondary()),
      )
      .onHovered(
        SegmentedControlItemStyler()
            .color(_carbonContentSwitcherHover())
            .label(.color(CarbonTokens.textPrimary()))
            .icon(.color(CarbonTokens.iconPrimary())),
      )
      .onPressed(
        SegmentedControlItemStyler()
            .color(_carbonContentSwitcherHover())
            .label(.color(CarbonTokens.textPrimary())),
      )
      .onSelected(
        SegmentedControlItemStyler()
            .color(CarbonTokens.layerSelectedInverse())
            .label(.color(CarbonTokens.textInverse()))
            .icon(.color(CarbonTokens.iconInverse())),
      )
      .onFocusVisible(
        SegmentedControlItemStyler().containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(color: CarbonTokens.focus(), width: 2),
            outlineOffset: -2,
          ),
        ),
      )
      .onDisabled(
        SegmentedControlItemStyler()
            .color(const Color(0x00000000))
            .label(.color(CarbonTokens.textDisabled()))
            .icon(.color(CarbonTokens.iconDisabled())),
      );

  return SegmentedControlStyler()
      .mainAxisSize(.max)
      .height(height)
      .borderRadius(.all(.circular(4)))
      .border(
        BoxBorderMix.all(
          BorderSideMix(color: CarbonTokens.borderInverse(), width: 1),
        ),
      )
      .clipBehavior(.antiAlias)
      .item(item)
      .onDisabled(
        SegmentedControlStyler().border(
          BoxBorderMix.all(
            BorderSideMix(color: CarbonTokens.borderDisabled(), width: 1),
          ),
        ),
      );
}

/// Declarative option for [CarbonContentSwitcher].
class CarbonContentSwitcherItem<T extends Object> {
  const CarbonContentSwitcherItem({
    required this.value,
    this.label,
    this.icon,
    this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
  }) : assert(label != null || icon != null);

  final T value;
  final String? label;
  final IconData? icon;
  final String? semanticLabel;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;
}

/// Equal-width Carbon switcher for mutually exclusive content views.
class CarbonContentSwitcher<T extends Object> extends StatelessWidget {
  const CarbonContentSwitcher({
    super.key,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.size,
  });

  final List<CarbonContentSwitcherItem<T>> items;
  final T? selectedValue;
  final ValueChanged<T>? onChanged;
  final bool enabled;
  final Axis orientation;
  final bool loop;
  final String? semanticLabel;
  final bool excludeSemantics;
  final CarbonSize? size;

  @override
  Widget build(BuildContext context) => RemixSegmentedControl<T>(
    items: items
        .map(
          (item) => RemixSegmentedControlItem<T>(
            value: item.value,
            label: item.label,
            icon: item.icon,
            semanticLabel: item.semanticLabel,
            enabled: item.enabled,
            focusNode: item.focusNode,
            autofocus: item.autofocus,
          ),
        )
        .toList(growable: false),
    selectedValue: selectedValue,
    onChanged: onChanged,
    enabled: enabled,
    orientation: orientation,
    loop: loop,
    semanticLabel: semanticLabel,
    excludeSemantics: excludeSemantics,
    style: carbonContentSwitcherStyle(size: size),
  );
}
