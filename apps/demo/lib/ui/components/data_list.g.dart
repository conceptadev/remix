// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_list.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal recipe for [RemixDataList].
class FortalDataList extends StatelessWidget {
  const FortalDataList({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const DataListStyler.create(),
    required this.items,
    this.orientation = Axis.horizontal,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final FortalDataListSize size;

  final bool highContrast;

  final DataListStyler style;

  final List<RemixDataListItem> items;

  final Axis orientation;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixDataList(
      key: this.key,
      style: fortalDataListStyle(
        size: this.size,
        highContrast: this.highContrast,
        style: this.style,
      ),
      items: this.items,
      orientation: this.orientation,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
