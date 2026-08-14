import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../foundation/carbon_layout_scope.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_field_frame.dart';

const _carbonSelectField = ContextToken(_resolveCarbonSelectField);
const _carbonSelectFieldHover = ContextToken(_resolveCarbonSelectFieldHover);
const _carbonSelectBorder = ContextToken(_resolveCarbonSelectBorder);
const _carbonSelectLayer = ContextToken(_resolveCarbonSelectLayer);
const _carbonSelectLayerHover = ContextToken(_resolveCarbonSelectLayerHover);
const _carbonSelectLayerSelected = ContextToken(
  _resolveCarbonSelectLayerSelected,
);

Color _resolveCarbonSelectField(BuildContext context) =>
    CarbonLayer.of(context).color(.field).resolve(context);

Color _resolveCarbonSelectFieldHover(BuildContext context) =>
    CarbonLayer.of(context).color(.fieldHover).resolve(context);

Color _resolveCarbonSelectBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderStrong).resolve(context);

Color _resolveCarbonSelectLayer(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

Color _resolveCarbonSelectLayerHover(BuildContext context) =>
    CarbonLayer.of(context).color(.layerHover).resolve(context);

Color _resolveCarbonSelectLayerSelected(BuildContext context) =>
    CarbonLayer.of(context).color(.layerSelected).resolve(context);

/// Carbon select/dropdown visual recipe.
SelectStyler carbonSelectStyle({
  CarbonSize size = .md,
  bool invalid = false,
  bool readOnly = false,
}) {
  final height = size.clampTo(.xs, .lg).height;
  final trigger = carbonSelectTriggerStyle(
    size: size,
    invalid: invalid,
    readOnly: readOnly,
  );

  final highlighted = SelectMenuItemStyler()
      .color(_carbonSelectLayerHover())
      .text(.color(CarbonTokens.textPrimary()));
  final item = SelectMenuItemStyler()
      .direction(.horizontal)
      .crossAxisAlignment(.center)
      .height(height)
      .padding(.horizontal(CarbonTokens.spacing05()))
      .text(
        .style(
          CarbonTokens.bodyCompact01.mix(),
        ).color(CarbonTokens.textSecondary()).maxLines(1).overflow(.ellipsis),
      )
      .indicator(.width(CarbonTokens.iconSize01()).alignment(.center))
      .icon(.size(CarbonTokens.iconSize01()).color(CarbonTokens.iconPrimary()))
      .onHovered(highlighted)
      .onFocused(highlighted)
      .onPressed(highlighted)
      .onSelected(SelectMenuItemStyler().color(_carbonSelectLayerSelected()))
      .onDisabled(
        SelectMenuItemStyler()
            .color(_carbonSelectLayer())
            .text(.color(CarbonTokens.textDisabled()))
            .icon(.color(CarbonTokens.iconDisabled())),
      );

  return SelectStyler()
      .trigger(trigger)
      .content(
        SelectContentStyler()
            .minWidth(160)
            .maxWidth(400)
            .color(_carbonSelectLayer())
            .decoration(
              BoxDecorationMix.boxShadow([
                BoxShadowMix(
                  color: CarbonTokens.shadow(),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ]),
            )
            .clipBehavior(.antiAlias),
      )
      .menuContainer(.direction(.vertical).mainAxisSize(.min))
      .item(item);
}

/// Carbon field chrome shared by select-like controls.
SelectTriggerStyler carbonSelectTriggerStyle({
  CarbonSize size = .md,
  bool invalid = false,
  bool readOnly = false,
}) {
  final height = size.clampTo(.xs, .lg).height;

  return SelectTriggerStyler()
      .width(.infinity)
      .height(height)
      .padding(.horizontal(CarbonTokens.spacing05()))
      .direction(.horizontal)
      .mainAxisAlignment(.spaceBetween)
      .crossAxisAlignment(.center)
      .spacing(CarbonTokens.spacing03())
      .color(readOnly ? const Color(0x00000000) : _carbonSelectField())
      .border(
        BoxBorderMix.bottom(
          BorderSideMix(
            color: invalid
                ? CarbonTokens.supportError()
                : readOnly
                ? _carbonSelectLayer()
                : _carbonSelectBorder(),
            width: invalid ? 2 : 1,
          ),
        ),
      )
      .label(
        .style(
          CarbonTokens.bodyCompact01.mix(),
        ).color(CarbonTokens.textPrimary()).maxLines(1).overflow(.ellipsis),
      )
      .placeholder(
        .style(
          CarbonTokens.bodyCompact01.mix(),
        ).color(CarbonTokens.textPlaceholder()).maxLines(1).overflow(.ellipsis),
      )
      .indicator(
        .size(CarbonTokens.iconSize01()).color(CarbonTokens.iconPrimary()),
      )
      .icon(.size(CarbonTokens.iconSize01()).color(CarbonTokens.iconPrimary()))
      .containerEffects(
        RemixBoxEffectsMix(
          outline: BorderSideMix(color: const Color(0x00000000), width: 2),
          outlineOffset: -2,
        ),
      )
      .onHovered(
        SelectTriggerStyler().color(
          readOnly ? const Color(0x00000000) : _carbonSelectFieldHover(),
        ),
      )
      .onFocusVisible(
        SelectTriggerStyler().containerEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(color: CarbonTokens.focus(), width: 2),
            outlineOffset: -2,
          ),
        ),
      )
      .onDisabled(
        SelectTriggerStyler()
            .border(BoxBorderMix.none)
            .label(.color(CarbonTokens.textDisabled()))
            .placeholder(.color(CarbonTokens.textDisabled()))
            .icon(.color(CarbonTokens.iconDisabled()))
            .indicator(.color(CarbonTokens.iconDisabled())),
      );
}

/// Base type for selectable entries and labeled groups.
sealed class CarbonSelectEntry<T extends Object> {
  const CarbonSelectEntry();
}

/// A typed Carbon select option.
final class CarbonSelectItem<T extends Object> extends CarbonSelectEntry<T> {
  const CarbonSelectItem({
    required this.value,
    required this.label,
    this.enabled = true,
    this.hidden = false,
    this.semanticLabel,
  });

  final T value;
  final String label;
  final bool enabled;
  final bool hidden;
  final String? semanticLabel;
}

/// A labeled group of Carbon select options.
final class CarbonSelectItemGroup<T extends Object>
    extends CarbonSelectEntry<T> {
  const CarbonSelectItemGroup({
    required this.label,
    required this.items,
    this.enabled = true,
  });

  final String label;
  final List<CarbonSelectItem<T>> items;
  final bool enabled;
}

/// Carbon single-select field with optional grouped options.
class CarbonSelect<T extends Object> extends StatelessWidget {
  const CarbonSelect({
    super.key,
    required this.items,
    required this.placeholder,
    this.label,
    this.helperText,
    this.errorText,
    this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.hideLabel = false,
    this.inline = false,
    this.size = .md,
    this.semanticLabel,
    this.focusNode,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .start,
    ),
  });

  final List<CarbonSelectEntry<T>> items;
  final String placeholder;
  final String? label;
  final String? helperText;
  final String? errorText;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final bool readOnly;
  final bool hideLabel;
  final bool inline;
  final CarbonSize size;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final OverlayPositionConfig positioning;

  bool _debugItemsAreValid() {
    final values = <T>{};
    for (final entry in items) {
      final entryItems = switch (entry) {
        CarbonSelectItem<T>() => [entry],
        CarbonSelectItemGroup<T>() => entry.items,
      };
      for (final item in entryItems) {
        if (!values.add(item.value)) {
          throw FlutterError('CarbonSelect item values must be unique.');
        }
      }
    }
    assert(
      selectedValue == null || values.contains(selectedValue),
      'CarbonSelect selectedValue must match a visible entry.',
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugItemsAreValid());
    final mapped = <RemixSelectItem<_CarbonSelectValue<T>>>[];
    var groupIndex = 0;
    for (final entry in items) {
      switch (entry) {
        case CarbonSelectItem<T>():
          if (!entry.hidden) mapped.add(_mapItem(entry));
        case CarbonSelectItemGroup<T>():
          final currentGroup = groupIndex++;
          mapped.add(
            RemixSelectItem(
              value: _CarbonSelectValue.group(currentGroup),
              label: entry.label,
              enabled: false,
              style: SelectMenuItemStyler()
                  .text(
                    .style(
                      CarbonTokens.headingCompact01.mix(),
                    ).color(CarbonTokens.textPrimary()),
                  )
                  .height(CarbonTokens.sizeSmall()),
            ),
          );
          for (final item in entry.items) {
            if (!item.hidden) {
              mapped.add(_mapItem(item, groupEnabled: entry.enabled));
            }
          }
      }
    }

    final select = RemixSelect<_CarbonSelectValue<T>>(
      trigger: RemixSelectTrigger(
        placeholder: placeholder,
        collapsedIcon: CarbonIcons.chevronDown,
        expandedIcon: CarbonIcons.chevronUp,
      ),
      items: mapped,
      selectedValue: selectedValue == null
          ? null
          : _CarbonSelectValue.item(selectedValue!),
      positioning: positioning,
      onChanged: readOnly ? null : (next) => onChanged?.call(next?.value),
      enabled: enabled,
      semanticLabel: semanticLabel ?? label,
      focusNode: focusNode,
      style: carbonSelectStyle(
        size: size,
        invalid: errorText != null,
        readOnly: readOnly,
      ),
    );

    return CarbonFieldFrame(
      label: label,
      helperText: helperText,
      errorText: errorText,
      enabled: enabled,
      hideLabel: hideLabel,
      inline: inline,
      child: select,
    );
  }

  RemixSelectItem<_CarbonSelectValue<T>> _mapItem(
    CarbonSelectItem<T> item, {
    bool groupEnabled = true,
  }) => .new(
    value: _CarbonSelectValue.item(item.value),
    label: item.label,
    enabled: groupEnabled && item.enabled,
    semanticLabel: item.semanticLabel,
  );
}

@immutable
final class _CarbonSelectValue<T extends Object> {
  const _CarbonSelectValue.item(this.value) : groupIndex = null;
  const _CarbonSelectValue.group(this.groupIndex) : value = null;

  final T? value;
  final int? groupIndex;

  @override
  bool operator ==(Object other) =>
      other is _CarbonSelectValue<T> &&
      other.value == value &&
      other.groupIndex == groupIndex;

  @override
  int get hashCode => Object.hash(value, groupIndex);
}
