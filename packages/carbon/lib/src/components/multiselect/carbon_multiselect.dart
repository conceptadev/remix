import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../foundation/carbon_layout_scope.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_field_frame.dart';
import '../menu/carbon_menu.dart';

const _carbonMultiselectField = ContextToken(_resolveCarbonMultiselectField);
const _carbonMultiselectFieldHover = ContextToken(
  _resolveCarbonMultiselectFieldHover,
);
const _carbonMultiselectBorder = ContextToken(_resolveCarbonMultiselectBorder);

Color _resolveCarbonMultiselectField(BuildContext context) =>
    CarbonLayer.of(context).color(.field).resolve(context);

Color _resolveCarbonMultiselectFieldHover(BuildContext context) =>
    CarbonLayer.of(context).color(.fieldHover).resolve(context);

Color _resolveCarbonMultiselectBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderStrong).resolve(context);

/// A typed option displayed by [CarbonMultiselect].
@immutable
final class CarbonMultiselectItem<T extends Object> {
  const CarbonMultiselectItem({
    required this.value,
    required this.label,
    this.enabled = true,
    this.semanticLabel,
  }) : assert(label != '');

  final T value;
  final String label;
  final bool enabled;
  final String? semanticLabel;
}

/// Carbon multi-select field backed by Remix's accessible checkbox menu.
class CarbonMultiselect<T extends Object> extends StatelessWidget {
  const CarbonMultiselect({
    super.key,
    required this.items,
    required this.placeholder,
    this.selectedValues = const {},
    this.onChanged,
    this.label,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.size = .md,
    this.semanticLabel,
    this.selectionLabelBuilder,
    this.controller,
    this.focusNode,
    this.positioning = const OverlayPositionConfig(
      side: .bottom,
      alignment: .start,
    ),
  });

  final List<CarbonMultiselectItem<T>> items;
  final String placeholder;
  final Set<T> selectedValues;
  final ValueChanged<Set<T>>? onChanged;
  final String? label;
  final String? helperText;
  final String? errorText;
  final bool enabled;
  final bool readOnly;
  final CarbonSize size;
  final String? semanticLabel;
  final String Function(List<CarbonMultiselectItem<T>> selected)?
  selectionLabelBuilder;
  final MenuController? controller;
  final FocusNode? focusNode;
  final OverlayPositionConfig positioning;

  bool _debugValuesAreValid() {
    final values = <T>{};
    for (final item in items) {
      assert(
        values.add(item.value),
        'CarbonMultiselect item values must be unique.',
      );
    }
    assert(
      selectedValues.every(values.contains),
      'CarbonMultiselect selectedValues must exist in items.',
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugValuesAreValid());
    final selected = List<CarbonMultiselectItem<T>>.unmodifiable(
      items.where((item) => selectedValues.contains(item.value)),
    );
    final triggerLabel = selected.isEmpty
        ? placeholder
        : (selectionLabelBuilder?.call(selected) ??
              selected.map((item) => item.label).join(', '));
    final interactive = enabled && !readOnly && onChanged != null;
    final height = size.clampTo(.xs, .lg).height;
    final borderColor = errorText == null
        ? _carbonMultiselectBorder()
        : CarbonTokens.supportError();
    final menuStyle =
        carbonMenuStyle(
          size: switch (size.clampTo(.xs, .lg)) {
            .xs => .xSmall,
            .sm => .small,
            .md => .medium,
            .lg || .xl || .x2l => .large,
          },
        ).trigger(
          MenuTriggerStyler()
              .width(.infinity)
              .height(height)
              .mainAxisSize(.max)
              .mainAxisAlignment(.spaceBetween)
              .padding(.horizontal(CarbonTokens.spacing05()))
              .color(
                readOnly ? const Color(0x00000000) : _carbonMultiselectField(),
              )
              .border(
                BoxBorderMix.bottom(
                  BorderSideMix(
                    color: borderColor,
                    width: errorText == null ? 1 : 2,
                  ),
                ),
              )
              .label(
                .style(CarbonTokens.bodyCompact01.mix())
                    .color(
                      enabled
                          ? selected.isEmpty
                                ? CarbonTokens.textPlaceholder()
                                : CarbonTokens.textPrimary()
                          : CarbonTokens.textDisabled(),
                    )
                    .maxLines(1)
                    .overflow(.ellipsis),
              )
              .onHovered(
                .color(
                  readOnly
                      ? const Color(0x00000000)
                      : _carbonMultiselectFieldHover(),
                ),
              )
              .onFocusVisible(
                .border(
                  BoxBorderMix.all(
                    BorderSideMix(color: CarbonTokens.focus(), width: 2),
                  ),
                ),
              ),
        );
    final menu = RemixMenu<T>(
      controller: controller,
      triggerFocusNode: focusNode,
      trigger: RemixMenuTrigger(label: triggerLabel),
      semanticLabel: semanticLabel ?? label ?? placeholder,
      positioning: positioning,
      items: [
        for (final item in items)
          RemixMenuCheckboxItem<T>(
            value: item.value,
            label: item.label,
            checked: selectedValues.contains(item.value),
            enabled: interactive && item.enabled,
            closeOnActivate: false,
            semanticLabel: item.semanticLabel,
            onChanged: interactive
                ? (checked) => _toggle(item.value, checked)
                : null,
          ),
      ],
      style: menuStyle,
    );

    return CarbonFieldFrame(
      label: label,
      helperText: helperText,
      errorText: errorText,
      enabled: enabled,
      child: IgnorePointer(ignoring: !interactive, child: menu),
    );
  }

  void _toggle(T value, bool checked) {
    final next = <T>{...selectedValues};
    checked ? next.add(value) : next.remove(value);
    onChanged?.call(UnmodifiableSetView(next));
  }
}
