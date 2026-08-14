import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layout_scope.dart';
import '../select/carbon_select.dart';

/// Carbon dropdown adapter for a flat collection of typed items.
class CarbonDropdown<T extends Object> extends StatelessWidget {
  const CarbonDropdown({
    super.key,
    required this.items,
    required this.label,
    this.titleText,
    this.helperText,
    this.errorText,
    this.selectedItem,
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

  final List<CarbonSelectItem<T>> items;
  final String label;
  final String? titleText;
  final String? helperText;
  final String? errorText;
  final T? selectedItem;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final bool readOnly;
  final bool hideLabel;
  final bool inline;
  final CarbonSize size;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final OverlayPositionConfig positioning;

  @override
  Widget build(BuildContext context) => CarbonSelect<T>(
    items: items,
    placeholder: label,
    label: titleText,
    helperText: helperText,
    errorText: errorText,
    selectedValue: selectedItem,
    onChanged: onChanged,
    enabled: enabled,
    readOnly: readOnly,
    hideLabel: hideLabel,
    inline: inline,
    size: size,
    semanticLabel: semanticLabel ?? titleText,
    focusNode: focusNode,
    positioning: positioning,
  );
}
